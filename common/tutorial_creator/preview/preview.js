"use strict";
const main_js = "https://oracle.github.io/learning-library/common/redwood-hol/js/main.js";

$.holdReady(true); //stops document.ready part from execution
$.getScript(main_js, function () {
    let previewType = window.localStorage.getItem("preview"); //retrieves the preview item from the browser local storage    
    $.when(
        $.getScript(showdown, function () {
            console.log("Showdown library loaded!");
        })
    ).done(function () {
        if (!previewType) {
            alert('Error understanding preview type. Please contact tool developer');
        } else {
            let articleElement = document.createElement('article'); //creating an article that would contain MD to HTML converted content
            let markdownContent, selectedTutorial, manifestFileContent;
            if (previewType === "home") {
                markdownContent = window.localStorage.getItem("mdValue"); //retrieve markdown content from local storage
                manifestFileContent = '{"tutorials": []}'; //setting blank content
                console.log('Local markdown file loaded!');
                selectedTutorial = setupRightNav(JSON.parse(manifestFileContent)); //populate side navigation based on content in the manifestFile
                showMd(articleElement, markdownContent, selectedTutorial);
            } else if (previewType === "manifest") {
                manifestFileContent = JSON.parse(window.localStorage.getItem("manifestValue")); //retrieve the manifestValue item from the window local storage                
                selectedTutorial = setupRightNav(JSON.parse(manifestFileContent)); //populate side navigation based on content in the manifestFile
                $.get(selectedTutorial.filename, function (markdown) { //reading MD file in the manifest and storing content in markdownContent variable
                    markdownContent = markdown;
                    console.log(selectedTutorial.filename + " loaded!");
                    showMd(articleElement, markdownContent, selectedTutorial);
                }).fail(function () {
                    alert(selectedTutorial.filename + ' not found! Please check that the file is available in the location provided in the manifest file.');
                });
            }
        }
    });
}).fail(function () {
    alert('Error in retrieving javascript files. This may be due to internet connectivity. Please check. If the problem still persists, contact the developer of the tool.');
});

function showMd(articleElement, markdownContent, selectedTutorial) {
    $(articleElement).html(new showdown.Converter({ tables: true }).makeHtml(markdownContent)); //converting markdownContent to HTML by using showndown plugin
    articleElement = renderVideos(articleElement); //adds iframe to videos 
    if (selectedTutorial) {
        articleElement = addPathToImageSrc(articleElement, selectedTutorial.filename); //adding the path for the image based on the filename in manifest
    }
    articleElement = updateH1Title(articleElement); //adding the h1 title in the Tutorial before the container div and removing it from the articleElement            
    articleElement = wrapSectionTag(articleElement); //adding each section within section tag                                        
    articleElement = wrapImgWithFigure(articleElement); //Wrapping images with figure, adding figcaption to all those images that have title in the MD
    if (selectedTutorial) {
        articleElement = addPathToAllRelativeHref(articleElement, selectedTutorial.filename); //adding the path for all HREFs based on the filename in manifest
    }
    articleElement = makeAnchorLinksWork(articleElement); //if there are links to anchors (for example: #hash-name), this function will enable it work
    articleElement = addTargetBlank(articleElement); //setting target for all ahrefs to _blank
    articleElement = allowCodeCopy(articleElement); //adds functionality to copy code from codeblocks               
    if (selectedTutorial) {
        updateHeadContent(selectedTutorial); //changing document head based on the manifest
    }
    $("main").html(articleElement); //placing the article element inside the main tag of the Tutorial template
    setTimeout(setupContentNav, 0); //sets up the collapse/expand button and open/close section feature
    collapseSection($("#module-content h2:not(:eq(0))"), "hide"); //collapses all sections by default
    $('#openNav').click(); //open the right side nav by default
    setupLeftNav();
}