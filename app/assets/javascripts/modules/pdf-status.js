'use strict';

window.moj.Modules.PdfStatus = {
    init: function () {
        console.log('[PdfStatus] running');

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
                console.log(`Missing button/message for ${type}`);
                return;
            }

            console.log(`Found elements for ${type}`);

            function preventClick(e) {
                e.preventDefault();
            }

            function disableDownloadLink() {
                console.log(`Disabling ${type}`);
                button.classList.add('govuk-button--disabled');
                button.setAttribute('aria-disabled', 'true');
                button.addEventListener('click', preventClick, true);
            }

            function enableDownloadLink() {
                console.log(`Enabling ${type}`);
                button.classList.remove('govuk-button--disabled');
                button.removeAttribute('aria-disabled');
                button.removeEventListener('click', preventClick, true);
            }

            function checkJobStatus(intervalId) {
                console.log(`Polling for ${type}`);
                fetch(`/steps/completion/summary/check_pdf_status?type=${type}`)
                    .then((response) => response.json())
                    .then((data) => {
                        console.log(`Response for ${type}`, data);
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
