/*
Author: Ashwin Agarwal
Contributors: Tom McGinn, Suresh Mohan
Last updated: 26-Aug-2020
Version: 20.2.9
*/

"use strict";
var showdown = "https://oracle.github.io/learning-library/common/redwood-hol/js/showdown.min.js";
const manifestFileName = "manifest.json";
const expandText = "Expand All Steps";
const collapseText = "Collapse All Steps";
const copyButtonText = "Copy";
const queryParam = "lab";
const utmParams = [{
    "url": "https://myservices.us.oraclecloud.com/mycloud/signup",
    "inParam": "customTrackingParam",
    "outParam": "sourceType"
}];
const nav_param_name = 'nav';
$.ajaxSetup({cache: true});

$(document).ready(function() {
    let manifestFileContent;
    $.when(
        $.getScript(showdown, function() {
            console.log("Showdown library loaded!");
        }),
        $.getJSON(manifestFileName, function(manifestFile) {
            manifestFileContent = manifestFile; //reading the manifest file and storing content in manifestFileContent variable
            if (manifestFileContent.workshoptitle !== undefined) { // if manifest file contains a field for workshop title
                document.getElementsByClassName("hol-Header-logo")[0].innerText = manifestFileContent.workshoptitle; // set title in the HTML output (DBDOC-2392)
            }
            console.log("Manifest file loaded!");
        }).fail(function() {
            alert("manifest.json file was not loaded. The manifest file should be co-located with the index.html file. If the file is co-located, check that the json format of the file is correct.");
        })
    ).done(function() {
        init();
        let selectedTutorial = setupTutorialNav(manifestFileContent); //populate side navigation based on content in the manifestFile
        let articleElement = document.createElement('article'); //creating an article that would contain MD to HTML converted content
        
        loadTutorial(articleElement, selectedTutorial, manifestFileContent, toggleTutorialNav);

    });
});

// specifies when to do when window is scrolled
$(window).scroll(function() {
    if ($('#contentBox').height() > $('#leftNav-toc').height()) {
        $('#leftNav-toc').addClass("scroll");
        if (($(window).scrollTop() + $(window).height()) > $('footer').offset().top) //if footer is seen
            $('#leftNav-toc').css('max-height', $('footer').offset().top - $('#leftNav-toc').offset().top);
        else
            $('#leftNav-toc').css('max-height', $(window).height() - $('#leftNav-toc').offset().top + $(window).scrollTop());
    } else {
        $('#leftNav-toc').removeClass("scroll");
        $('#leftNav-toc').css('max-height', '');
    }
    try {
        if ((document.querySelector('.selected .active').getBoundingClientRect().y + document.querySelector('.selected .active').clientHeight) > $(window).height())
            $('.selected .active')[0].scrollIntoView(false);
    } catch(e) {};
});

let init = () => {
    //remove right nav because it is no longer needed
    if ($('#mySidenav'))
        $('#mySidenav').remove();
    $('.hol-Header-actions').prependTo('.hol-Header-wrap');
    $('<div id="tutorial-title"></div>').appendTo(".hol-Header-logo")[0];
    
    $('#openNav').click(function() {
        let nav_param = getParam(nav_param_name);
        if (!nav_param || nav_param === 'open') {
            window.history.pushState('', '', setParam(window.location.href, nav_param_name, 'close'));
        } else if (nav_param === 'close') {
            window.history.pushState('', '', setParam(window.location.href, nav_param_name, 'open'));
        }
        toggleTutorialNav();
    });

}
// the main function that loads the tutorial
let loadTutorial = (articleElement, selectedTutorial, manifestFileContent, callbackFunc=null) => {
    $.get(selectedTutorial.filename, function(markdownContent) { //reading MD file in the manifest and storing content in markdownContent variable
        console.log(selectedTutorial.filename + " loaded!");

        markdownContent = singlesource(markdownContent, selectedTutorial.type); // implement show/hide feature based on the if tag (DBDOC-2430)
        markdownContent = convertBracketInsideCopyCode(markdownContent); // converts <> tags inside copy tag to &lt; and &gt; (DBDOC-2404)
        markdownContent = addPathToImageSrc(markdownContent, selectedTutorial.filename); //adding the path for the image based on the filename in manifest

        $(articleElement).html(new showdown.Converter({
            tables: true
        }).makeHtml(markdownContent)); //converting markdownContent to HTML by using showndown plugin

        articleElement = renderVideos(articleElement); //adds iframe to videos
        articleElement = updateH1Title(articleElement); //adding the h1 title in the Tutorial before the container div and removing it from the articleElement
        articleElement = wrapSectionTag(articleElement); //adding each section within section tag
        articleElement = wrapImgWithFigure(articleElement); //Wrapping images with figure, adding figcaption to all those images that have title in the MD
        articleElement = addPathToAllRelativeHref(articleElement, selectedTutorial.filename); //adding the path for all HREFs based on the filename in manifest
        articleElement = makeAnchorLinksWork(articleElement); //if there are links to anchors (for example: #hash-name), this function will enable it work
        articleElement = addTargetBlank(articleElement); //setting target for all ahrefs to _blank
        articleElement = allowCodeCopy(articleElement); //adds functionality to copy code from codeblocks
        articleElement = injectUtmParams(articleElement);
        updateHeadContent(selectedTutorial, manifestFileContent.workshoptitle); //changing document head based on the manifest
    }).done(function() {
        $("main").html(articleElement); //placing the article element inside the main tag of the Tutorial template    
        setTimeout(setupContentNav, 0); //sets up the collapse/expand button and open/close section feature
        collapseSection($("#module-content h2:not(:eq(0))"), "none"); //collapses all sections by default
        setupTocNav();

        if (callbackFunc)
            callbackFunc();
    }).fail(function() {
        alert(selectedTutorial.filename + ' not found! Please check that the file is available in the location provided in the manifest file.');
    });
}
let toggleTutorialNav = () => {
    let nav_param = getParam(nav_param_name);

    if (!nav_param || nav_param === 'open') {
        $('.hol-Nav-list > li:not(.selected)').attr('tabindex', '0');
        $('#leftNav-toc, #leftNav, #contentBox').addClass('open').removeClass('close');
    } else if (nav_param === 'close') {
        $('.hol-Nav-list > li:not(.selected)').attr('tabindex', '-1');
        $('#leftNav-toc, #leftNav, #contentBox').addClass('close').removeClass('open');
    }

    $(window).scroll();
}

/* The following functions creates and populates the tutorial navigation.*/
let setupTutorialNav = (manifestFileContent) => {
    let div = $(document.createElement('div')).attr('id', 'leftNav-toc');
    let ul = $(document.createElement('ul')).addClass('hol-Nav-list');

    $(manifestFileContent.tutorials).each(function(i, tutorial) {
        let shortTitle = createShortNameFromTitle(tutorial.title);
        
        $(document.createElement('li')).each(function() {
            $(this).click(function() {
                changeTutorial(shortTitle);
            });
            $(this).attr('id', shortTitle);
            $(this).text(tutorial.title); //The title specified in the manifest appears in the side nav as navigation
            $(this).appendTo(ul);

            /* for accessibility */
            $(this).keydown(function(e) {
                if (e.keyCode === 13 || e.keyCode === 32) { //means enter and space
                    e.preventDefault();
                    changeTutorial(shortTitle);
                }
            });
            /* accessibility code ends here */
        });
    });

    $(ul).appendTo(div);
    $(div).appendTo('#leftNav');
    return selectTutorial(manifestFileContent);
}

let selectTutorial = (manifestFileContent) => {
    $('#' + getParam(queryParam)).addClass('selected'); //add class selected to the tutorial that is selected by using the ID
    $('.selected').unbind('keydown');

    //find which tutorial in the manifest file is selected
    for (var i = 0; i < manifestFileContent.tutorials.length; i++) {
        if (getParam(queryParam) === createShortNameFromTitle(manifestFileContent.tutorials[i].title))
            return manifestFileContent.tutorials[i];
    }
    
    //if no title has selected class, selected class is added to the first class
    $('.hol-Nav-list').find('li:eq(0)').addClass("selected");
    return manifestFileContent.tutorials[0]; //return the first tutorial is no tutorial is matches
}

/* Setup toc navigation and tocify */
let setupTocNav = () => {
    $(".hol-Nav-list .selected").wrapInner("<div tabindex='0'></div>")
    $(".hol-Nav-list .selected div").prepend($(document.createElement('div')).addClass('arrow').text('+'));
    $(".hol-Nav-list .selected").unbind('click');

    $(".hol-Nav-list .selected > div").click(function(e) {
        if ($('.selected div.arrow').text() === '-') {
            $('#toc').fadeOut('fast');
            $('.selected div.arrow').text('+');
        }
        else {
            $('#toc').fadeIn('fast');
            $('.selected div.arrow').text('-');
        }
    });

    /* for accessibility */
    $(".hol-Nav-list .selected > div").keydown(function(e) {
        if (e.keyCode === 13 || e.keyCode === 32) { //means enter and space
                    e.preventDefault();
            $(this).click()
        }
    });
    /* accessibility code ends here */

    $(window).scroll();
    $('#toc').appendTo(".hol-Nav-list .selected");
    $('.selected div.arrow').click();


    let toc = $("#toc").tocify({
        selectors: "h2"
    }).data("toc-tocify");
    toc.setOptions({
        extendPage: false,
        smoothScroll: false,
        scrollTo: $('.hol-Header').height(),
        highlightDefault: true,
        showEffect: "fadeIn",
        showAndHide: false
    });

    $('.tocify-item').each(function() {
        let itemName = $(this).attr('data-unique');
        if ($(this) !== $('.tocify-item:eq(0)')) { //as the first section is not expandable or collapsible
            $(this).click(function(e) { //if left nav item is clicked, the corresponding section expands
                expandSectionBasedOnHash(itemName);
            });
        }
        if (itemName === location.hash.slice(1)) { //if the hash value matches, it clicks it after some time.
            let click = $(this);
            setTimeout(function() {
                $(click).click();
            }, 1000)
        }
    });
}

/* The following function performs the event that must happen when the lab links in the navigation is clicked */
let changeTutorial = (shortTitle) => location.href = unescape(setParam(window.location.href, queryParam, shortTitle));

/*the following function changes the path of images as per the path of the MD file.
This ensures that the images are picked up from the same location as the MD file.
The manifest file can be in any location.*/
let addPathToImageSrc = (markdownContent, myUrl) => {
    let imagesRegExp = new RegExp(/!\[.*?\]\((.*?)\)/g);
    let contentToReplace = []; // content that needs to be replaced
    let matches;

    myUrl = myUrl.replace(/\/[^\/]+$/, "/"); //removing filename from the url

    do {
        matches = imagesRegExp.exec(markdownContent);
        if (matches === null) {
            $(contentToReplace).each(function(index, value) {
                markdownContent = markdownContent.replace(value.replace, value.with);
            });
            return markdownContent;
        }

        if (myUrl.indexOf("/") !== 1) {    
            matches[1] = matches[1].split(' ')[0];
            if (matches[1].indexOf("http") === -1) {
                contentToReplace.push({
                    "replace": '(' + matches[1],
                    "with": '(' + myUrl + matches[1]
                });
            }
        }
    } while (matches);
}
/* The following function adds the h1 title before the container div. It picks up the h1 value from the MD file. */
let updateH1Title = (articleElement) => {
    $('#tutorial-title').text("\t\t>\t\t" + $(articleElement).find('h1').text());
    // $(articleElement).find('h1').remove(); //Removing h1 from the articleElement as it has been added to the HTML file already
    return articleElement;
}
/* This function picks up the entire converted content in HTML, and break them into sections. */
let wrapSectionTag = (articleElement) => {
    $(articleElement).find('h2').each(function() {
        $(this).nextUntil('h2').andSelf().wrapAll('<section></section>');
    });
    return articleElement;
}
/* Wrapping all images in the article element with Title in the MD, with figure tags, and adding figcaption dynamically.
The figcaption is in the format Description of illustration [filename].
The image description files must be added inside the files folder in the same location as the MD file.*/
let wrapImgWithFigure = (articleElement) => {
    $(articleElement).find("img").on('load', function() {
        if ($(this)[0].width > 100 || $(this)[0].height > 100 || $(this).attr("title") !== undefined) { // only images with title or width or height > 100 get wrapped (DBDOC-2397)
            $(this).wrap("<figure></figure>"); //wrapping image tags with figure tags
            if ($.trim($(this).attr("title"))) {
                let imgFileNameWithoutExtn = $(this).attr("src").split("/").pop().split('.').shift(); //extracting the image filename without extension
                $(this).parent().append('<figcaption><a href="files/' + imgFileNameWithoutExtn + '.txt">Description of illustration [' + imgFileNameWithoutExtn + ']</figcaption>');
            } else {
                $(this).removeAttr('title');
            }
        }
    });
    return articleElement;
}
/*the following function changes the path of the HREFs based on the absolute path of the MD file.
This ensures that the files are linked correctly from the same location as the MD file.
The manifest file can be in any location.*/
let addPathToAllRelativeHref = (articleElement, myUrl) => {
    if (myUrl.indexOf("/") !== -1) {
        myUrl = myUrl.replace(/\/[^\/]+$/, "/"); //removing filename from the url
        $(articleElement).find('a').each(function() {
            if ($(this).attr("href").indexOf("http") === -1 && $(this).attr("href").indexOf("?") !== 0 && $(this).attr("href").indexOf("#") !== 0) {
                $(this).attr("href", myUrl + $(this).attr("href"));
            }
        });
    }
    return articleElement;
}
/* the following function makes anchor links work by adding an event to all href="#...." */
let makeAnchorLinksWork = (articleElement) => {
    $(articleElement).find('a[href^="#"]').each(function() {
        let href = $(this).attr('href');
        if (href !== "#") { //eliminating all plain # links
            $(this).click(function() {
                expandSectionBasedOnHash(href.split('#')[1]);
            });
        }
    });
    return articleElement;
}
/*the following function sets target for all HREFs to _blank */
let addTargetBlank = (articleElement) => {
    $(articleElement).find('a').each(function() {
        if ($(this).attr('href').indexOf("http") === 0) //ignoring # hrefs
            $(this).attr('target', '_blank'); //setting target for ahrefs to _blank
    });
    return articleElement;
}
/* Sets the title, contentid, description, partnumber, and publisheddate attributes in the HTML page.
The content is picked up from the manifest file entry*/
let updateHeadContent = (tutorialEntryInManifest, workshoptitle) => {
    (workshoptitle !== undefined) ?
    document.title = workshoptitle + " | " + tutorialEntryInManifest.title:
        document.title = tutorialEntryInManifest.title;

    const metaProperties = [{
        name: "contentid",
        content: tutorialEntryInManifest.contentid
    }, {
        name: "description",
        content: tutorialEntryInManifest.description
    }, {
        name: "partnumber",
        content: tutorialEntryInManifest.partnumber
    }, {
        name: "publisheddate",
        content: tutorialEntryInManifest.publisheddate
    }];
    $(metaProperties).each(function(i, metaProp) {
        if (metaProp.content) {
            let metaTag = document.createElement('meta');
            $(metaTag).attr(metaProp).prependTo('head');
        }
    });
}
/* Enables collapse/expand feature for the steps */
let setupContentNav = () => {
    //adds the expand collapse button before the second h2 element
    $("#module-content h2:eq(1)")
        .before('<button id="btn_toggle" class="hol-ToggleRegions plus">' + expandText + '</button>')
        .prev().on('click', function(e) {
            ($(this).text() === expandText) ? expandSection($("#module-content h2:not(:eq(0))"), "show"): collapseSection($("#module-content h2:not(:eq(0))"), "hide");
            changeButtonState(); //enables the expand all parts and collapse all parts button
        });
    //enables the feature that allows expand collapse of sections
    $("#module-content h2:not(:eq(0))").click(function(e) {
        ($(this).hasClass('plus')) ? expandSection(this, "fade"): collapseSection(this, "fade");
        changeButtonState();
    });
    /* for accessibility */
    $("#module-content h2:not(:eq(0))").attr('tabindex', '0');
    $('#module-content h2:not(:eq(0))').keydown(function(e) {
        if (e.keyCode === 13 || e.keyCode === 32) { //means enter and space
            e.preventDefault();
            if ($(this).hasClass('plus'))
                expandSection($(this), "fade");
            else
                collapseSection($(this), "fade");
        }
    });
    /* accessibility code ends here */
    window.scrollTo(0, 0);
}
/* Expands the section */
let expandSection = (anchorElement, effect) => {
    if (effect === "show") {
        $(anchorElement).nextUntil("#module-content h1, #module-content h2").show('fast'); //expand the section incase it is collapsed
    } else if (effect === "fade") {
        $(anchorElement).nextUntil("#module-content h1, #module-content h2").fadeIn('fast');
    }
    $(anchorElement).addClass("minus");
    $(anchorElement).removeClass("plus");
}
/* Collapses the section */
let collapseSection = (anchorElement, effect) => {
    if (effect === "hide") {
        $(anchorElement).nextUntil("#module-content h1, #module-content h2").hide('fast'); //collapses the section incase it is expanded
    } else if (effect === "fade") {
        $(anchorElement).nextUntil("#module-content h1, #module-content h2").fadeOut('fast');
    } else if (effect == "none") {
        $(anchorElement).nextUntil("#module-content h1, #module-content h2").attr('style', 'display:none;');
    }
    $(anchorElement).addClass('plus');
    $(anchorElement).removeClass('minus');
}
/* Detects the state of the collapse/expand button and changes it if required */
let changeButtonState = () => {
    if ($("#module-content h2.minus").length <= $("#module-content h2.plus").length) { //if all sections are expanded, it changes text to expandText
        $('#btn_toggle').text(expandText);
        $("#btn_toggle").addClass('plus');
        $("#btn_toggle").removeClass('minus');
    } else {
        $('#btn_toggle').text(collapseText);
        $("#btn_toggle").addClass('minus');
        $("#btn_toggle").removeClass('plus');
    }
}
/* Expands section on page load based on the hash. Expands section when the leftnav item is clicked */
let expandSectionBasedOnHash = (itemName) => {
    let anchorElement = $('div[name="' + itemName + '"]').next(); //anchor element is always the next of div (eg. h2 or h3)
    if ($(anchorElement).hasClass('hol-ToggleRegions')) //if the next element is the collpase/expand button
        anchorElement = $(anchorElement).next();
    if (anchorElement[0].tagName !== 'H2') {
        anchorElement = $(anchorElement).siblings('h2');
    }
    if ($(anchorElement).hasClass('minus') || $(anchorElement).hasClass('plus'))
        expandSection(anchorElement, "fade");
    $(anchorElement)[0].scrollIntoView();
    window.scrollTo(0, window.scrollY - $('.hol-Header').height());
    changeButtonState();
}
/* adds code copy functionality in codeblocks. The code that needs to be copied needs to be wrapped in <copy> </copy> tag */
let allowCodeCopy = (articleElement) => {
    $(articleElement).find('pre code').each(function() {
        let code = $(document.createElement('code')).html($(this).text());
        if ($(code).has('copy').length) {
            $(code).find('copy').contents().unwrap().wrap('<span class="copy-code">');
            $(this).html($(code).html());
            $(this).before('<button class="copy-button" title="Copy text to clipboard">' + copyButtonText + '</button>');
        }
    });
    $(articleElement).find('.copy-button').click(function() {
        let copyText = $(this).next().find('.copy-code').map(function() {
            return $(this).text().trim();
        }).get().join('\n');
        let dummy = $('<textarea>').val(copyText).appendTo(this).select();
        document.execCommand('copy');
        $(dummy).remove();
        $(this).parent().animate({
            opacity: 0.2
        }).animate({
            opacity: 1
        });
    });
    return articleElement;
}
/* adds iframe to videos so that it renders in the same page.
The MD code should be in the format [](youtube:<enter_video_id>) for it to render as iframe. */
let renderVideos = (articleElement) => {
    $(articleElement).find('a[href^="youtube:"]').each(function() {
        $(this).after('<div class="video-container"><iframe src="https://www.youtube.com/embed/' + $(this).attr('href').split(":")[1] + '" frameborder="0" allowfullscreen></div>');
        $(this).remove();
    });
    return articleElement;
}
/* remove all content that is not of type specified in the manifest file. Then remove all if tags.*/
let singlesource = (markdownContent, type) => {
    let ifTagRegExp = new RegExp(/<\s*if type="([^>]*)">([\s\S|\n]*?)<\/\s*if>/gm);
    let contentToReplace = []; // content that needs to be replaced
    if ($.type(type) !== 'array')
        type = Array(type);

    let matches;
    do {
        matches = ifTagRegExp.exec(markdownContent);
        if (matches === null) {
            $(contentToReplace).each(function(index, value) {
                markdownContent = markdownContent.replace(value.replace, value.with);
            });
            return markdownContent;
        }
        ($.inArray(matches[1], type) === -1) ? // check if type specified matches content
        contentToReplace.push({
                "replace": matches[0],
                "with": ''
            }): // replace with blank if type doesn't match
            contentToReplace.push({
                "replace": matches[0],
                "with": matches[2]
            }); // replace with text without if tag if type matches
    } while (matches);
}
/* converts < > symbols inside the copy tag to &lt; and &gt; */
let convertBracketInsideCopyCode = (markdownContent) => {
    let copyRegExp = new RegExp(/<copy>([\s\S|\n]*?)<\/copy>/gm);

    markdownContent = markdownContent.replace(copyRegExp, function(code) {
        code = code.replace('<copy>', '');
        code = code.replace('</copy>', '');
        code = code.replace(/</g, '&lt;');
        code = code.replace(/>/g, '&gt;');
        return '<copy>' + code.trim() + '</copy>';
    });

    return markdownContent;
}
/* injects tracking code into links specified in the utmParams variable */
let injectUtmParams = (articleElement) => {
    let currentUrl = window.location.href;
    $(utmParams).each(function(index, item) {
        let inParamValue = getParam(item.inParam);
        if (inParamValue) {
            $(articleElement).find('a[href*="' + item.url + '"]').each(function() {
                let targetUrl = $(this).attr('href');
                $(this).attr('href', unescape(setParam(targetUrl, item.outParam, inParamValue)));
            });
        }
    });

    /* hack for manual links like this ?lab=xx. Should be removed later. */
    $(utmParams).each(function(index, item) {
        let inParamValue = getParam(item.inParam);
        if (inParamValue) {
            $(articleElement).find('a[href*="?' + queryParam + '="]').each(function() {
                let targetUrl = $(this).attr('href') + '&' + item.inParam + '=' + inParamValue;
                $(this).attr('href', unescape(targetUrl));
            });
        }
    });
    /* remove till here */
    return articleElement;
}
/* set the query parameter value  */
let setParam = (url, paramName, paramValue) => {
    let onlyUrl = (url.split('?')[0]).split('#')[0];
    let params = url.replace(onlyUrl, '').split('#')[0]; 
    let hashAnchors = url.replace(onlyUrl + params, '');
    hashAnchors = "";

    let existingParamValue = getParam(paramName);
    if (existingParamValue) {
        return onlyUrl + params.replace(paramName + '=' + existingParamValue, paramName + '=' + paramValue) + hashAnchors;
    } else {
        if (params.length === 0 || params.length === 1) {
            return onlyUrl + '?' + paramName + '=' + paramValue + hashAnchors;
        }
        return onlyUrl + params + '&' + paramName + '=' + paramValue + hashAnchors;
    }
}
/* get the query parameter value */
let getParam = (paramName) => {
    let params = window.location.search.substring(1).split('&');
    for (var i = 0; i < params.length; i++) {
        if (params[i].split('=')[0] == paramName) {
            return params[i].split('=')[1];
        }
    }
    return false;
}
/* The following function creates shortname from title */
let createShortNameFromTitle = (title) => {
    if (!title) {
        alert("The title in the manifest file cannot be blank!");
        return "ErrorTitle";
    }
    const removeFromTitle = ["-a-", "-in-", "-of-", "-the-", "-to-", "-an-", "-is-", "-your-", "-you-", "-and-", "-from-", "-with-"];
    const folderNameRestriction = ["<", ">", ":", "\"", "/", "\\\\", "|", "\\?", "\\*", "&"];
    let shortname = title.toLowerCase().replace(/ /g, '-').trim().substr(0, 50);
    $.each(folderNameRestriction, function(i, value) {
        shortname = shortname.replace(new RegExp(value, 'g'), '');
    });
    $.each(removeFromTitle, function(i, value) {
        shortname = shortname.replace(new RegExp(value, 'g'), '-');
    });
    if (shortname.length > 40) {
        shortname = shortname.substr(0, shortname.lastIndexOf('-'));
    }
    return shortname;
}