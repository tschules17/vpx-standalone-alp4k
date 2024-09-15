function runJS() {
    // Get the modal
    var modal = document.getElementById("myModal");

    var imageNodes = document.getElementsByTagName('img');
    for (var i=0; i<imageNodes.length; i++)
    {          
        imageNodes[i].addEventListener('click', function() {
            showImageInModal(this);
        });
    }

    // Get the image and insert it inside the modal - use its "alt" text as a caption
    var modalImg = document.getElementById("img01");
    var captionText = document.getElementById("caption");

    function showImageInModal(img) {
        modal.style.display = "block";
        modalImg.src = img.src;
        captionText.innerHTML = img.alt;
    }

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }
}