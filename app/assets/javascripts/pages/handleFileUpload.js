async function handleFileUpload(input) {
    const form = input.closest("form");
    const formData = new FormData(form);

    const response = await fetch(form.action, {
        method: "POST",
        body: formData,
        headers: {
            "X-Requested-With": "XMLHttpRequest"
        }
    });

    if (!response.ok) {
        return;
    }

    const html = await response.text();
    const container = document.querySelector("#uploaded-documents-container");

    if (!container) {
        return;
    }

    const parser = new DOMParser();
    const doc = parser.parseFromString(html, "text/html");
    const newContainer = doc.querySelector("#uploaded-documents-container");

    if (newContainer) {
        container.replaceWith(newContainer);
    } else {
        container.innerHTML = html;
    }
}
