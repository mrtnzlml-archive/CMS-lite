<?php

namespace Search\Dql;

use Doctrine\ORM\Query\AST\Functions\FunctionNode;
use Doctrine\ORM\Query\Lexer;
use Doctrine\ORM\Query\Parser;
use Doctrine\ORM\Query\SqlWalker;

/**
 * "MATCH" "(" StateFieldPathExpression {"," StateFieldPathExpression}* ")" "AGAINST" "(" StringPrimary ["BOOLEAN"] ["EXPAND"] ")"
 *
 * @see: http://stackoverflow.com/a/17536071/3135248 or https://github.com/beberlei/DoctrineExtensions/blob/master/src/Query/Mysql/MatchAgainst.php
 */
class MatchAgainst extends FunctionNode
{

	/** @var \Doctrine\ORM\Query\AST\PathExpression[] */
	protected $pathExp = NULL;

	/** @var string */
	protected $against = NULL;

	/** @var boolean */
	protected $booleanMode = FALSE;

	/** @var boolean */
	protected $queryExpansion = FALSE;

	/**
	 * @param \Doctrine\ORM\Query\SqlWalker $sqlWalker
	 *
	 * @return string
	 */
	public function getSql(SqlWalker $sqlWalker)
	{
		$fields = [];
		foreach ($this->pathExp as $pathExp) {
			$fields[] = $pathExp->dispatch($sqlWalker);
		}
		$against = $sqlWalker->walkStringPrimary($this->against)
			. ($this->booleanMode ? ' IN BOOLEAN MODE' : '')
			. ($this->queryExpansion ? ' WITH QUERY EXPANSION' : '');
		return sprintf('MATCH (%s) AGAINST (%s)', implode(', ', $fields), $against);
	}

	/**
	 * @param \Doctrine\ORM\Query\Parser $parser
	 *
	 * @return void
	 */
	public function parse(Parser $parser)
	{
		// MATCH
		$parser->match(Lexer::T_IDENTIFIER);
		$parser->match(Lexer::T_OPEN_PARENTHESIS);

		// First Path Expression is mandatory
		$this->pathExp = [];
		$this->pathExp[] = $parser->StateFieldPathExpression();

		// Subsequent Path Expressions are optional
		$lexer = $parser->getLexer();
		while ($lexer->isNextToken(Lexer::T_COMMA)) {
			$parser->match(Lexer::T_COMMA);
			$this->pathExp[] = $parser->StateFieldPathExpression();
		}

		$parser->match(Lexer::T_CLOSE_PARENTHESIS);

		// AGAINST
		if (strtolower($lexer->lookahead['value']) !== 'against') {
			$parser->syntaxError('against');
		}

		$parser->match(Lexer::T_IDENTIFIER);
		$parser->match(Lexer::T_OPEN_PARENTHESIS);
		$this->against = $parser->StringPrimary();

		if (strtolower($lexer->lookahead['value']) === 'boolean') {
			$parser->match(Lexer::T_IDENTIFIER);
			$this->booleanMode = TRUE;
		}

		if (strtolower($lexer->lookahead['value']) === 'expand') {
			$parser->match(Lexer::T_IDENTIFIER);
			$this->queryExpansion = TRUE;
		}

		$parser->match(Lexer::T_CLOSE_PARENTHESIS);
	}

}
