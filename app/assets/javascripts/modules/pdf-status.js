'use strict';

moj.Modules.PdfStatus = {
    init: function () {
        const button = document.getElementById('completedDownloadButton');
        const message = document.getElementById('completedGeneratingMessage');

        if (!button || !message) {
            return;
        }

        function disableDownloadLink() {
            button.classList.add('govuk-button--disabled');
            button.setAttribute('aria-disabled', 'true');
        }

        function enableDownloadLink() {
            button.classList.remove('govuk-button--disabled');
            button.removeAttribute('aria-disabled');
        }

        function checkJobStatus(intervalId) {
            fetch(`/steps/completion/summary/`)
                .then((response) => {
                    if (response.ok) {
                        clearInterval(intervalId);
                        enableDownloadLink();
                        message.classList.add('hidden');
                    }
                });
        }

        $(button).on('click', function () {
            disableDownloadLink();
            message.classList.remove('hidden');
            const intervalId = setInterval(() => checkJobStatus(intervalId), 3000);
        });
    },
};
