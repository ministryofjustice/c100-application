// $(document).ready(function () {
//     const setups = [
//         {
//             type: 'draft',
//             buttonId: 'draftDownloadButton',
//             messageId: 'draftGeneratingMessage',
//         },
//         {
//             type: 'completed',
//             buttonId: 'completedDownloadButton',
//             messageId: 'completedGeneratingMessage',
//         },
//     ];
//
//     setups.forEach(({ type, buttonId, messageId }) => {
//         const button = document.getElementById(buttonId);
//         const message = document.getElementById(messageId);
//
//         if (!button || !message) return;
//
//         console.log('<-- elements found -->');
//         function preventClick(e) {
//             e.preventDefault();
//         }
//
//         function disableDownloadLink() {
//             console.log('<-- disabling button -->');
//             button.classList.add('govuk-button--disabled');
//             button.setAttribute('aria-disabled', 'true');
//             button.addEventListener('click', preventClick, true);
//         }
//
//         function enableDownloadLink() {
//             console.log('<-- enabling button -->');
//             button.classList.remove('govuk-button--disabled');
//             button.removeAttribute('aria-disabled');
//             button.removeEventListener('click', preventClick, true);
//         }
//
//         function checkJobStatus(intervalId) {
//             console.log('<-- polling job status -->');
//             fetch(`/steps/completion/summary/check_pdf_status?type=${type}`)
//                 .then(response => {
//                     return response.json();
//                 })
//                 .then(data => {
//                     console.log('<-- received response from job -->');
//                     if (data.job_completed) {
//                         console.log('<-- PDF ready -->');
//                         enableDownloadLink();
//                         message.classList.add('hidden');
//                         clearInterval(intervalId);
//                     } else {
//                         console.log('<-- waiting for PDF -->');
//                         disableDownloadLink();
//                         message.classList.remove('hidden');
//                     }
//                 })
//         }
//
//         disableDownloadLink();
//
//         const intervalId = setInterval(() => checkJobStatus(intervalId), 2000);
//         checkJobStatus(intervalId);
//     });
// });
