let hideGhPageLink = function() {
  let currentUrl = window.location.href;
  if (currentUrl.includes("oracle.github.io/learning-library/workshops/vbcs") === true) {
    console.log(true);
    let element = document.getElementById("ghpagesnote");
    // console.log(element);
    element.classList.add("gh-pages-note");
  }
}

// document.onload = hideGhPageLink();
