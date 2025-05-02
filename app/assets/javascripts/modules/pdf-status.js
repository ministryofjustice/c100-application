'use strict';
moj.Modules.PdfStatus = {
    init: function () {
        const setups = [
            {
                type: 'draft',
                buttonId: 'draftDownloadButton',
                messageId: 'draftGeneratingMessage',
            },
            {
                type: 'completed',
                buttonId: 'completedDownloadButton',
                messageId: 'completedGeneratingMessage',
            },
        ];

        setups.forEach(({ type, buttonId, messageId }) => {
            const button = document.getElementById(buttonId);
            const message = document.getElementById(messageId);

            if (!button || !message) {
                return;
            }

            function preventClick(e) {
                e.preventDefault();
            }

            function disableDownloadLink() {
                button.classList.add('govuk-button--disabled');
                button.setAttribute('aria-disabled', 'true');
                button.addEventListener('click', preventClick, true);
            }

            function enableDownloadLink() {
                button.classList.remove('govuk-button--disabled');
                button.removeAttribute('aria-disabled');
                button.removeEventListener('click', preventClick, true);
            }

            function checkJobStatus(intervalId) {
                fetch(`/steps/completion/summary/check_pdf_status?type=${type}`)
                    .then((response) => response.json())
                    .then((data) => {
                        if (data.job_completed) {
                            enableDownloadLink();
                            message.classList.add('hidden');
                            clearInterval(intervalId);
                        } else {
                            disableDownloadLink();
                            message.classList.remove('hidden');
                        }
                    });
            }

            disableDownloadLink();
            const intervalId = setInterval(() => checkJobStatus(intervalId), 2000);
            checkJobStatus(intervalId);
        });
    },
};
