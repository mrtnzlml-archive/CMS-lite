$(function () {
	var options = {
		//debug: true,
		retry: {
			enableAuto: true
		},
		failedUploadTextDisplay: {
			mode: 'custom',
			responseProperty: 'error'
		}
	};

	var image_selector = $('#image-uploader');
	if (image_selector.length) {
		options['request'] = {
			endpoint: $(image_selector).data('ajax-handle')
		};
		options['validation'] = {
			allowedExtensions: parseExtensions(image_selector),
			sizeLimit: image_selector.data('size-limit')
		};
		$(image_selector).fineUploader(options);
	}

	var file_selector = $('#file-uploader');
	if (file_selector.length) {
		options['request'] = {
			endpoint: $(file_selector).data('ajax-handle')
		};
		options['validation'] = {
			allowedExtensions: parseExtensions(file_selector),
			sizeLimit: image_selector.data('size-limit')
		};
		file_selector.fineUploader(options);
	}

	function parseExtensions(selector) {
		return selector.data('extensions').split(';');
	}
});
