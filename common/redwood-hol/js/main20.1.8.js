/*
Author: Ashwin Agarwal
Contributors: Tom McGinn, Suresh Mohan
Last updated: 07-Aug-2020
Version: 20.1.8
*/

"use strict";
var showdown = "https://oracle.github.io/learning-library/common/redwood-hol/js/showdown.min.js";
const manifestFileName = "manifest.json";
const expandText = "Expand All Steps";
const collapseText = "Collapse All Steps";
const anchorOffset = 70; //if header is fixed, it should be 70. Otherwise, 0.
const copyButtonText = "Copy";
const queryParam = "lab";
const utmParams = [{
    "url": "https://myservices.us.oraclecloud.com/mycloud/signup",
    "inParam": "customTrackingParam",
    "outParam": "sourceType"
}];

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
        let selectedTutorial = setupRightNav(manifestFileContent); //populate side navigation based on content in the manifestFile
        let articleElement = document.createElement('article'); //creating an article that would contain MD to HTML converted content

        $.get(selectedTutorial.filename, function(markdownContent) { //reading MD file in the manifest and storing content in markdownContent variable
            console.log(selectedTutorial.filename + " loaded!");

            markdownContent = singlesource(markdownContent, selectedTutorial.type); // implement show/hide feature based on the if tag (DBDOC-2430)
            markdownContent = convertBracketInsideCopyCode(markdownContent); // converts <> tags inside copy tag to &lt; and &gt; (DBDOC-2404)
            $(articleElement).html(new showdown.Converter({
                tables: true
            }).makeHtml(markdownContent)); //converting markdownContent to HTML by using showndown plugin

            articleElement = renderVideos(articleElement); //adds iframe to videos
            articleElement = addPathToImageSrc(articleElement, selectedTutorial.filename); //adding the path for the image based on the filename in manifest
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
            collapseSection($("#module-content h2:not(:eq(0))"), "hide"); //collapses all sections by default
            $('#openNav').click(); //open the right side nav by default
            setupLeftNav();
        }).fail(function() {
            alert(selectedTutorial.filename + ' not found! Please check that the file is available in the location provided in the manifest file.');
        });
    });
});
/* The following function increases the width of the side navigation div to open it. */
function openRightSideNav() {
    $('#mySidenav').attr("style", "width: 270px; overflow-y: auto; box-shadow: 0 0 48px 24px rgba(0, 0, 0, .3);");
    $('#mySidenav li, #closeNav').attr('tabindex', '0');
    $('h1').css("margin-right", "270px");
    setTimeout(function() {
        document.getElementsByClassName('selected')[0].scrollIntoView(false);
    }, 1000);
}
/* The following function decreases the width of the side navigation div to close it. */
function closeRightSideNav() {
    $('#mySidenav li, #closeNav').attr('tabindex', '-1');
    $('#mySidenav').attr("style", "width: 0px; overflow-y: hidden; box-shadow: 0 0 48px 24px rgba(0, 0, 0, 0);");
    $('h1').css("margin-right", "0px");
}
/* The following functions creates and populates the right side navigation including the open button that appears in the header.
The navigation appears only when the manifest file has more than 1 tutorial. The title that appears in the side navigation
is picked up from the manifest file. */
function setupRightNav(manifestFileContent) {
    let allTutorials = manifestFileContent.tutorials;
    let selectedTutorial;
    if (allTutorials.length <= 1) {
        $('.rightNav').hide();
    } else if (allTutorials.length > 1) { //means it is a workshop
        $('.rightNav').show();
        //adding tutorials from JSON and linking them with ?shortnames
        $(allTutorials).each(function(i, tutorial) {
            let shortTitle = createShortNameFromTitle(tutorial.title);

            let li = $(document.createElement('li')).click(function() {
                rightNavClick(shortTitle);
            });

            $(li).text(tutorial.title); //The title specified in the manifest appears in the side nav as navigation
            try {
                if (new URL(window.location.href).searchParams.get(queryParam) === shortTitle) {
                    $(li).attr("class", "selected");
                    selectedTutorial = tutorial;
                }
            } catch (err) { //if IE, new URL() method fails
                if (getParam(queryParam) == shortTitle) {
                    $(li).attr("class", "selected");
                    selectedTutorial = tutorial;
                }
            }

            $(li).appendTo($('#mySidenav ul'));
            /* for accessibility */
            $(li).keydown(function(e) {
                if (e.keyCode === 13 || e.keyCode === 32) { //means enter and space
                    e.preventDefault();
                    rightNavClick(shortTitle);
                }
            });
            /* accessibility code ends here */
        });
        if (!$('#mySidenav ul').find('li').hasClass("selected")) { //if no title has selected class, selected class is added to the first class
            $('#mySidenav ul').find('li:eq(0)').addClass("selected");
        }
        $('#openNav').click(openRightSideNav);
        $('#closeNav').click(closeRightSideNav);
    }
    if (selectedTutorial === undefined) {
        return allTutorials[0];
    } else {
        return selectedTutorial;
    }
}
/* The following function performs the event that must happen when the lab links in the right navigation is clicked */
function rightNavClick(shortTitle) {
    try {
        let labUrl = new URL(window.location.href);
        labUrl.searchParams.set(queryParam, shortTitle);
        location.href = unescape(labUrl);
    } catch (err) { //code for IE since it doesn't support new URL()
        location.href = unescape(setParam(window.location.href, queryParam, shortTitle));
    }
}
/* set the query parameter value - used only for IE */
function setParam(url, paramName, paramValue) {
    let onlyUrl = url.split('?')[0];
    let params = url.replace(onlyUrl, '').split('#')[0];
    let hashAnchors = url.replace(onlyUrl + params, '');

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
/* get the query parameter value - used only for IE */
function getParam(paramName) {
    let params = window.location.search.substring(1).split('&');
    for (var i = 0; i < params.length; i++) {
        if (params[i].split('=')[0] == paramName) {
            return params[i].split('=')[1];
        }
    }
    return false;
}
/* The following function creates shortname from title */
function createShortNameFromTitle(title) {
    if (!title) {
        alert("The title in the manifest file cannot be blank!");
        return "ErrorTitle";
    }
    const removeFromTitle = ["-a-", "-in-", "-of-", "-the-", "-to-", "-an-", "-is-", "-your-", "-you-", "-and-", "-from-", "-with-"];
    const folderNameRestriction = ["<", ">", ":", "\"", "/", "\\\\", "|", "\\?", "\\*"];
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
/*the following function changes the path of images as per the path of the MD file.
This ensures that the images are picked up from the same location as the MD file.
The manifest file can be in any location.*/
function addPathToImageSrc(articleElement, myUrl) {
    if (myUrl.indexOf("/") !== -1) {
        myUrl = myUrl.replace(/\/[^\/]+$/, "/"); //removing filename from the url
        $(articleElement).find('img').each(function() {
            if ($(this).attr("src").indexOf("http") === -1) {
                $(this).attr("src", myUrl + $(this).attr("src"));
            }
        });
    }

    return articleElement;
}
/* The following function adds the h1 title before the container div. It picks up the h1 value from the MD file. */
function updateH1Title(articleElement) {
    let h1 = document.createElement('h1');
    $('#container').before($(h1).text($(articleElement).find('h1').text()));
    $(articleElement).find('h1').remove(); //Removing h1 from the articleElement as it has been added to the HTML file already
    return articleElement;
}
/* This function picks up the entire converted content in HTML, and break them into sections. */
function wrapSectionTag(articleElement) {
    $(articleElement).find('h2').each(function() {
        $(this).nextUntil('h2').andSelf().wrapAll('<section></section>');
    });
    return articleElement;
}
/* Wrapping all images in the article element with Title in the MD, with figure tags, and adding figcaption dynamically.
The figcaption is in the format Description of illustration [filename].
The image description files must be added inside the files folder in the same location as the MD file.*/
function wrapImgWithFigure(articleElement) {
    // $(articleElement).find("img").each(function () {
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
function addPathToAllRelativeHref(articleElement, myUrl) {
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
function makeAnchorLinksWork(articleElement) {
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
function addTargetBlank(articleElement) {
    $(articleElement).find('a').each(function() {
        if ($(this).attr('href').indexOf("http") === 0) //ignoring # hrefs
            $(this).attr('target', '_blank'); //setting target for ahrefs to _blank
    });
    return articleElement;
}
/* Sets the title, contentid, description, partnumber, and publisheddate attributes in the HTML page.
The content is picked up from the manifest file entry*/
function updateHeadContent(tutorialEntryInManifest, workshoptitle) {
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
/* Setup left navigation and tocify */
function setupLeftNav() {
    let toc = $("#toc").tocify({
        selectors: "h2, h3, h4"
    }).data("toc-tocify");
    toc.setOptions({
        extendPage: false,
        smoothScroll: false,
        scrollTo: anchorOffset,
        highlightDefault: true,
        showEffect: "fadeIn"
    });

    $('.tocify-item').each(function() {
        let itemName = $(this).attr('data-unique');
        if ($(this) !== $('.tocify-item:eq(0)')) { //as the first section is not expandable or collapsible
            $(this).click(function() { //if left nav item is clicked, the corresponding section expands
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
    $(window).scroll(function() {
        if ($(this).scrollTop() + anchorOffset > $("article").offset().top) {
            $('#toc').addClass("scroll");
            if (($(window).scrollTop() + $(window).height()) > $('footer').position().top) //if footer is seen
                $('#toc').height($('footer').position().top - $(window).scrollTop() - anchorOffset);
            else
                $('#toc').height('100%');
        } else {
            $('#toc').removeClass("scroll");
        }
    });
}
/* Enables collapse/expand feature for the steps */
function setupContentNav() {
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
/* Manage contentBox height */
function heightAdjust() {
    $('#contentBox').height('100%');
    if ($('#contentBox').height() < $('#leftNav').height()) {
        $('#contentBox').height($('#leftNav').height());
    }
}
/* Expands the section */
function expandSection(anchorElement, effect) {
    if (effect === "show") {
        $(anchorElement).nextUntil("#module-content h1, #module-content h2").show(heightAdjust); //expand the section incase it is collapsed
    } else if (effect === "fade") {
        $(anchorElement).nextUntil("#module-content h1, #module-content h2").fadeIn(heightAdjust);
    }
    $(anchorElement).addClass("minus");
    $(anchorElement).removeClass("plus");
}
/* Collapses the section */
function collapseSection(anchorElement, effect) {
    if (effect === "hide") {
        $(anchorElement).nextUntil("#module-content h1, #module-content h2").hide(heightAdjust); //collapses the section incase it is expanded
    } else if (effect === "fade") {
        $(anchorElement).nextUntil("#module-content h1, #module-content h2").fadeOut(heightAdjust);
    }
    $(anchorElement).addClass('plus');
    $(anchorElement).removeClass('minus');
}
/* Detects the state of the collapse/expand button and changes it if required */
function changeButtonState() {
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
function expandSectionBasedOnHash(itemName) {
    let anchorElement = $('div[name="' + itemName + '"]').next(); //anchor element is always the next of div (eg. h2 or h3)
    if ($(anchorElement).hasClass('hol-ToggleRegions')) //if the next element is the collpase/expand button
        anchorElement = $(anchorElement).next();
    if (anchorElement[0].tagName !== 'H2') {
        anchorElement = $(anchorElement).siblings('h2');
    }
    if ($(anchorElement).hasClass('minus') || $(anchorElement).hasClass('plus'))
        expandSection(anchorElement, "fade");
    $(anchorElement)[0].scrollIntoView();
    window.scrollTo(0, window.scrollY - anchorOffset);
    changeButtonState();
}
/* adds code copy functionality in codeblocks. The code that needs to be copied needs to be wrapped in <copy> </copy> tag */
function allowCodeCopy(articleElement) {
    $(articleElement).find('pre code').each(function() {
        let code = $(document.createElement('code')).html($(this).text());
        if ($(code).has('copy').length) {
            $(code).find('copy').contents().unwrap().wrap('<span class="copy-code">');
            $(this).html($(code).html());
            // $(this).parent().wrap('<div>').before('<button class="copy-button" title="Copy text to clipboard">' + copyButtonText + '</button>');
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
function renderVideos(articleElement) {
    $(articleElement).find('a[href^="youtube:"]').each(function() {
        $(this).after('<div class="video-container"><iframe src="https://www.youtube.com/embed/' + $(this).attr('href').split(":")[1] + '" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></div>');
        $(this).remove();
    });
    return articleElement;
}
/* remove all content that is not of type specified in the manifest file. Then remove all if tags.*/
function singlesource(markdownContent, type) {
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
function convertBracketInsideCopyCode(markdownContent) {
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
function injectUtmParams(articleElement) {
    try {
        let currentUrl = new URL(window.location.href);
        $(utmParams).each(function(index, item) {
            let inParamValue = currentUrl.searchParams.get(item.inParam);
            if (inParamValue) {
                $(articleElement).find('a[href*="' + item.url + '"]').each(function() {
                    let targetUrl = new URL($(this).attr('href'));
                    targetUrl.searchParams.set(item.outParam, inParamValue);
                    $(this).attr('href', unescape(targetUrl.href));
                });
            }
        });
    } catch (err) { //code for IE since new URL() isn't supported in IE.
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
    }
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
