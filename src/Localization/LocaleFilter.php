<?php

namespace Localization;

use Doctrine\ORM\Mapping\ClassMetaData;
use Doctrine\ORM\Query\Filter\SQLFilter;

class LocaleFilter extends SQLFilter
{

	public function addFilterConstraint(ClassMetadata $targetEntity, $targetTableAlias)
	{
		// Check if the entity implements the ILocaleAware interface
		if (!$targetEntity->reflClass->implementsInterface(ILocaleAware::class)) {
			return "";
		}
		// getParameter applies quoting automatically
		return $targetTableAlias . '.locale_id = ' . $this->getParameter('locale');
	}

}
