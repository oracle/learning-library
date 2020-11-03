/*
Author: Ashwin Agarwal
Contributors: Tom McGinn, Suresh Mohan
Last updated: 6-Oct-2020
Version: 20.2.23
*/
"use strict";
var showdown = "https://oracle.github.io/learning-library/common/redwood-hol/js/showdown.min.js";

let main = function() {
    let manifestFileName = "manifest.json";
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
    const extendedNav = {'#last': 2, '#next' : 1, '#prev': -1, "#first": -2};
    $.ajaxSetup({cache: true});

    let manifest_global;

    $(document).ready(function() {
        let manifestFileContent;
        if (getParam("manifest")) {
            manifestFileName = getParam("manifest");
        }
        $.when(
            $.getScript(showdown, function() {
                console.log("Showdown library loaded!");
            }),
            $.getJSON(manifestFileName, function(manifestFile) {
                if (manifestFile.workshoptitle !== undefined) { // if manifest file contains a field for workshop title
                    document.getElementsByClassName("hol-Header-logo")[0].innerText = manifestFile.workshoptitle; // set title in the HTML output (DBDOC-2392)
                }
                console.log("Manifest file loaded!");


                if(getParam("manifest")) {
                    $(manifestFile.tutorials).each(function() {
                        if($(this)[0].filename.indexOf("http") == -1) {
                            $(this)[0].filename = manifestFileName.substring(0, manifestFileName.lastIndexOf("/") + 1) + $(this)[0].filename;
                        }
                    });
                }

                // added for include feature: [DBDOC-2434] Include any file inside of Markdown before rendering
                for (let short_name in manifestFile.include) {
                    $.get(manifestFile.include[short_name], function(included_file_content) {
                        manifestFile.include[short_name] = included_file_content;
                    });
                }
                manifest_global = manifestFileContent = manifestFile; //reading the manifest file and storing content in manifestFileContent variable
            })
        ).done(function() {
            init();
            let selectedTutorial = setupTutorialNav(manifestFileContent); //populate side navigation based on content in the manifestFile
            let articleElement = document.createElement('article'); //creating an article that would contain MD to HTML converted content

            loadTutorial(articleElement, selectedTutorial, manifestFileContent, toggleTutorialNav);
            prepareToc(manifestFileContent);

            setTimeout(function() {
                if(location.hash.slice(1))
                    expandSectionBasedOnHash($("li[data-unique='" + location.hash.slice(1) + "']"));

                // if($('#leftNav-toc').hasClass('scroll'))
                $('.selected')[0].scrollIntoView(true);

            }, 1000);
        });
    });

    // specifies when to do when window is scrolled
    $(window).scroll(function() {
        // if ($('#contentBox').height() > $('#leftNav-toc').height() || ($('#leftNav-toc').height() + $('header').height()) > $(window).height()) {
        if (($('#contentBox').outerHeight() + $('header').outerHeight() + $('footer').outerHeight()) > $(window).outerHeight()) {
            $('#leftNav-toc').addClass("scroll");

            if (($(window).scrollTop() + $(window).height()) > $('footer').offset().top) {//if footer is seen
                $('#leftNav-toc').css('max-height', $('footer').offset().top - $('#leftNav-toc').offset().top);
            }
            else {
                $('#leftNav-toc').css('max-height', $(window).height() - $('header').height());
            }
        }
        else {
            $('#leftNav-toc').removeClass("scroll");
        }

        try {
            if ((document.querySelector('.selected .active').getBoundingClientRect().y + document.querySelector('.selected .active').clientHeight) > $(window).height() && $('#leftNav-toc').hasClass("scroll"))
                $('.selected .active')[0].scrollIntoView(false);
        } catch(e) {};

        let active = $('#contentBox').find('[data-unique]').first();
        $('#contentBox').find('[data-unique]').each(function() {
            if(($(this).offset().top - $(window).scrollTop() - $('header').height()) < Math.abs($(active).offset().top - $(window).scrollTop())) {
                active = $(this);
            }
        });
        $('.selected .toc .toc-item').removeClass('active');
        $('.selected .toc').find('[data-unique="' + $(active).attr('data-unique') + '"]').addClass('active');
    });

    $(window).on('hashchange', function(e) {
        try { // if next or previous is not available then it raises exception
            let position = extendedNav[e.target.location.hash]
            if (position  !== undefined)
                changeTutorial(createShortNameFromTitle(selectTutorial(manifest_global, position).title));
        } catch(e) {};
    });

    let init = () => {
        //remove right nav because it is no longer needed
        if ($('#mySidenav'))
            $('#mySidenav').hide();
        $('.hol-Header-actions').prependTo('.hol-Header-wrap').show();
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

        $('.hol-Footer-topLink').after($(document.createElement('a')).addClass('hol-Footer-rightLink hide'));
        $('.hol-Footer-topLink').before($(document.createElement('a')).addClass('hol-Footer-leftLink hide'));
        $('#contentBox').css('min-height', $(window).height() - $('header').outerHeight() - $('footer').outerHeight());
    }
    // the main function that loads the tutorial
    let loadTutorial = (articleElement, selectedTutorial, manifestFileContent, callbackFunc=null) => {
        $.get(selectedTutorial.filename, function(markdownContent) { //reading MD file in the manifest and storing content in markdownContent variable
            console.log(selectedTutorial.filename + " loaded!");

            markdownContent = singlesource(markdownContent, selectedTutorial.type); // implement show/hide feature based on the if tag (DBDOC-2430)
            markdownContent = include(markdownContent, manifestFileContent.include); // added for include feature: [DBDOC-2434] Include any file inside of Markdown before rendering
            markdownContent = convertBracketInsideCopyCode(markdownContent); // converts <> tags inside copy tag to &lt; and &gt; (DBDOC-2404)
            markdownContent = addPathToImageSrc(markdownContent, selectedTutorial.filename); //adding the path for the image based on the filename in manifest
            markdownContent = addPathToTypeHrefs(markdownContent); // if type is specified in the markdown, then add absolute path for it.

            $(articleElement).html(new showdown.Converter({
                tables: true
            }).makeHtml(markdownContent)); //converting markdownContent to HTML by using showndown plugin

            articleElement = showRightAndLeftArrow(articleElement, manifestFileContent);
            articleElement = renderVideos(articleElement); //adds iframe to videos
            articleElement = updateH1Title(articleElement); //adding the h1 title in the Tutorial before the container div and removing it from the articleElement
            articleElement = wrapSectionTag(articleElement); //adding each section within section tag
            articleElement = wrapImgWithFigure(articleElement); //Wrapping images with figure, adding figcaption to all those images that have title in the MD
            articleElement = addPathToAllRelativeHref(articleElement, selectedTutorial.filename); //adding the path for all HREFs based on the filename in manifest
            articleElement = setH2Name(articleElement);
            articleElement = makeAnchorLinksWork(articleElement); //if there are links to anchors (for example: #hash-name), this function will enable it work
            articleElement = addTargetBlank(articleElement); //setting target for all ahrefs to _blank
            articleElement = allowCodeCopy(articleElement); //adds functionality to copy code from codeblocks
            articleElement = injectUtmParams(articleElement);
            updateHeadContent(selectedTutorial, manifestFileContent.workshoptitle); //changing document head based on the manifest

            if (getParam("qa") == "true") {
                articleElement = performQA(articleElement, markdownContent);
            }
        }).done(function() {
            $("main").html(articleElement); //placing the article element inside the main tag of the Tutorial template
            setTimeout(setupContentNav, 0); //sets up the collapse/expand button and open/close section feature

            if (getParam("qa") == "true") {
                dragElement(document.getElementById("qa-report"));
            } else {
                collapseSection($("#module-content h2:not(:eq(0))"), "none"); //collapses all sections by default
            }

            if (callbackFunc)
                callbackFunc();

        }).fail(function() {
            console.log(selectedTutorial.filename + ' not found! Please check that the file is available in the location provided in the manifest file.');
        });
    }

    // added for include feature: [DBDOC-2434] Include any file inside of Markdown before rendering
    let include = (markdown, include) => {
        for (let short_name in include) {
            markdown = markdown.split("[](include:" + short_name + ")").join(include[short_name]);
        }
        return markdown;
    }

    let addPathToTypeHrefs = (markdown) => {
        let regex_type = new RegExp(/\[(?:.+?)\]\((&type=(\S*?))\)/g);
        let matches;

        do {
            matches = regex_type.exec(markdown);
            if (matches !== null) {
                markdown = markdown.replace(matches[1], setParam(window.location.href, "type", matches[2]));
            }
        } while(matches);

        return markdown;
    }

    let prepareToc = (manifestFileContent) => {
        let h2_regex = new RegExp(/^##\s(.+)*/gm);
        let h2s_list = [];
        let matches;

        $(manifestFileContent.tutorials).each(function(i, tutorial) {
            let ul;
            let div = document.createElement('div');
            $(div).attr('id', 'toc' + i).addClass('toc');

            $.get(tutorial.filename, function(markdownContent) { //reading MD file in the manifest and storing content in markdownContent variable
                markdownContent = singlesource(markdownContent, tutorial.type);
                markdownContent = include(markdownContent, manifestFileContent.include);

                do {
                    matches = h2_regex.exec(markdownContent);
                    if (matches !== null) {
                        ul = document.createElement('ul');
                        $(ul).append($(document.createElement('li')).addClass('toc-item').text(matches[1].replace(/\**/g, '').replace(/\##/g, '')).attr('data-unique', alphaNumOnly(matches[1])));
                        $(ul).click(function() {
                            if($(this).parent().parent().parent().hasClass('selected')) {
                                location.hash = alphaNumOnly($(this).text());
                                expandSectionBasedOnHash($(this).find('li').attr('data-unique'));
                            }
                            else {
                                changeTutorial(createShortNameFromTitle($(this).parent().parent().find('span').text()), alphaNumOnly($(this).text()));
                            }

                        });
                        $(ul).appendTo(div);
                    }
                } while(matches);

            });
            $('.hol-Nav-list li')[i].append(div);
        });



        setTimeout(function() {
            let anchorItem = $('.selected li[data-unique="' + location.hash.slice(1) + '"]');
            if (anchorItem.length !== 0)
                $(anchorItem)[0].click();
        }, 1000);


        $(".hol-Nav-list>li").wrapInner("<div></div>")
        $(".hol-Nav-list>li>div").prepend($(document.createElement('div')).addClass('arrow').text('+'));

        $('.hol-Nav-list > li > div .arrow').click(function() {
            if($(this).text() === '-') {
                $(this).next().next().fadeOut('fast', function() {
                    $(window).scroll();
                });
                $(this).text('+');
            } else {
                $(this).next().next().fadeIn('fast', function() {
                    $(window).scroll();
                });
                $(this).text('-');
            }
        });

        $('.selected div.arrow').text('-');
        $('.hol-Nav-list > li:not(.selected) .toc').hide();
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
        setTimeout(function() {
            $(window).scroll();
        }, 100);
    }

    /* The following functions creates and populates the tutorial navigation.*/
    let setupTutorialNav = (manifestFileContent) => {
        let div = $(document.createElement('div')).attr('id', 'leftNav-toc');
        let ul = $(document.createElement('ul')).addClass('hol-Nav-list');

        $(manifestFileContent.tutorials).each(function(i, tutorial) {
            let shortTitle = createShortNameFromTitle(tutorial.title);

            $(document.createElement('li')).each(function() {
                $(this).click(function(e) {
                    if(!$(e.target).hasClass('arrow') && !$(e.target).hasClass('toc-item') && !$(e.target).hasClass('toc-item active')) {
                        if ($(e.target).parent().parent().hasClass('selected')) {
                            try {
                                $('.selected .arrow').click();
                            } catch (e) {}
                        }
                        else {
                            changeTutorial(shortTitle);
                        }
                    }
                });
                $(this).attr('id', 'tut-' + shortTitle);
                $(this).text(tutorial.title).wrapInner("<span></span>"); //The title specified in the manifest appears in the side nav as navigation
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

    let selectTutorial = (manifestFileContent, position=0) => {
        $('#tut-' + getParam(queryParam)).addClass('selected'); //add class selected to the tutorial that is selected by using the ID
        $('.selected').unbind('keydown');

        if (position === -2) return manifestFileContent.tutorials[0];
        if (position === 2) return manifestFileContent.tutorials[manifestFileContent.tutorials.length - 1];

        //find which tutorial in the manifest file is selected
        for (var i = 0; i < manifestFileContent.tutorials.length; i++) {
            if (getParam(queryParam) === createShortNameFromTitle(manifestFileContent.tutorials[i].title))
                return manifestFileContent.tutorials[i+position];
        }

        //if no title has selected class, selected class is added to the first class
        $('.hol-Nav-list').find('li:eq(0)').addClass("selected");
        return manifestFileContent.tutorials[0+position]; //return the first tutorial is no tutorial is matches
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
    }

    /* The following function performs the event that must happen when the lab links in the navigation is clicked */
    let changeTutorial = (shortTitle, anchor="") => {
        if (anchor !== "") anchor = '#' + anchor;
        location.href = unescape(setParam(window.location.href, queryParam, shortTitle) + anchor);
    }

    /*the following function changes the path of images as per the path of the MD file.
    This ensures that the images are picked up from the same location as the MD file.
    The manifest file can be in any location.*/
    let addPathToImageSrc = (markdownContent, myUrl) => {
        let imagesRegExp = new RegExp(/!\[.*?\]\((.*?)\)/g);
        let contentToReplace = []; // content that needs to be replaced
        let matches;

        myUrl = myUrl.substring(0, myUrl.lastIndexOf('/') + 1); //removing filename from the url

        do {
            matches = imagesRegExp.exec(markdownContent);
            if (matches === null) {
                $(contentToReplace).each(function(index, value) {
                    markdownContent = markdownContent.replace(value.replace, value.with);
                });
                return markdownContent;
            }

            // if (myUrl.indexOf("/") !== 1) {
                matches[1] = matches[1].split(' ')[0];
                if (matches[1].indexOf("http") === -1) {
                    contentToReplace.push({
                        "replace": '(' + matches[1],
                        /* "with": '(' + myUrl + matches[1] TMM: changed 10/6/20*/
                        "with": '(' + myUrl + matches[1].trim()
                    });
                }
            // }
        } while (matches);
    }
    /* The following function adds the h1 title before the container div. It picks up the h1 value from the MD file. */
    let updateH1Title = (articleElement) => {
        $('#tutorial-title').text("\t\t›\t\t" + $(articleElement).find('h1').text());
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
            if ($(this).attr('href').indexOf("http") === 0 && $(this).attr('href').indexOf("&type=") == -1) //ignoring # hrefs
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
            $(anchorElement).nextUntil("#module-content h1, #module-content h2").show('fast', function() {
                $(window).scroll();
            }); //expand the section incase it is collapsed
        } else if (effect === "fade") {
            $(anchorElement).nextUntil("#module-content h1, #module-content h2").fadeIn('fast', function() {
                $(window).scroll();
            });
        }
        $(anchorElement).addClass("minus");
        $(anchorElement).removeClass("plus");
    }
    /* Collapses the section */
    let collapseSection = (anchorElement, effect) => {
        if (effect === "hide") {
            $(anchorElement).nextUntil("#module-content h1, #module-content h2").hide('fast', function() {
                $(window).scroll();
            }); //collapses the section incase it is expanded
        } else if (effect === "fade") {
            $(anchorElement).nextUntil("#module-content h1, #module-content h2").fadeOut('fast', function() {
                $(window).scroll();
            });
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
        try {
            if (anchorElement[0].tagName !== 'H2') {
                anchorElement = $(anchorElement).siblings('h2');
            }

            if ($(anchorElement).hasClass('minus') || $(anchorElement).hasClass('plus'))
                expandSection(anchorElement, "fade");
            $(anchorElement)[0].scrollIntoView();
            window.scrollTo(0, window.scrollY - $('.hol-Header').height());
            changeButtonState();
        } catch(e) {};
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

        if (getParam("type") !== false) {
            type = getParam("type");
        }

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
            console.log("The title in the manifest file cannot be blank!");
            return "ErrorTitle";
        }
        const removeFromTitle = ["-a-", "-in-", "-of-", "-the-", "-to-", "-an-", "-is-", "-your-", "-you-", "-and-", "-from-", "-with-"];
        const folderNameRestriction = ["<", ">", ":", "\"", "/", "\\\\", "|", "\\?", "\\*", "&", "\\.", ","];
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

    let showRightAndLeftArrow = (articleElement, manifestFileContent) => {
        if (selectTutorial(manifestFileContent, extendedNav['#next']) !== undefined) {
            $('.hol-Footer-rightLink').removeClass('hide').addClass('show').attr({'href': '#next', 'title': 'Next'}).text('Next');
        }
        if (selectTutorial(manifestFileContent, extendedNav['#prev']) !== undefined) {
            $('.hol-Footer-leftLink').removeClass('hide').addClass('show').attr({'href': '#prev', 'title': 'Previous'}).text('Previous');
        }
        return articleElement;
    }

    let setH2Name = (articleElement) => {

        $(articleElement).find('h2').each(function() {
            $(this).before($(document.createElement('div')).attr(
                {
                    'name': alphaNumOnly($(this).text()),
                    'data-unique': alphaNumOnly($(this).text())
                }
            ));
        });
        return articleElement;
    }

    let alphaNumOnly = (text) => text.replace(/[^[A-Za-z0-9:?\(\)]+?/g, '');


    // QA part of the code
    let performQA = (articleElement, markdownContent) => {
        let error_div = $(document.createElement('div')).attr('id', 'qa-report').html("<div id='qa-reportheader'></div><div id='qa-reportbody'><ol></ol></div>");
        const more_info = "Please see <a href='https://confluence.oraclecorp.com/confluence/x/ep81Y' target='_blank'>using the LiveLabs template</a> for more information.";

        let urlExists = (url, callback) => {
          $.ajax({
            type: 'HEAD',
            url: url,
            success: function(){
              callback(true);
            },
            error: function() {
              callback(false);
            }
          });
        }

        let add_issue = (error_msg, error_type = "", follow_id = false) => {
            if (follow_id) {
                $(error_div).find('ol').append("<li class=" + error_type + ">" + error_msg + " <small onclick=\"window.scrollTo({top:$('." + follow_id + "').offset().top - ($('header').outerHeight() + 10), behavior: 'smooth'});\">(show)</small></li>");
            } else {
                $(error_div).find('ol').append("<li class=" + error_type + ">" + error_msg + "</li>");
            }

        }

        let checkH1 = (article) => {
            if ($(article).find('h1').length !== 1) {
                add_issue("Only a single title is allowed, please edit your Markdown file and remove or recast other content tagged with a single #.", "major-error");
                $(article).find('h1').addClass('error');
            }
        }

        let checkForHtmlTags = (markdown) => {
            let count = (markdown.match(new RegExp("<a href=", "g")) || []).length;
            if (count == 1)
                add_issue("There is " + count + " occurrence of HTML (for example: &lt;a href=...&gt;) in your Markdown. Please do not embed HTML in Markdown.");
            else if (count > 1)
                add_issue("There are " + count + " occurrences of HTML (for example: &lt;a href=...&gt;) in your Markdown. Please do not embed HTML in Markdown.");
        }

        let checkSecondH2Tag = (article) => {
            if ($(article).find('h2:eq(1)').text().substr(0, 4).indexOf("STEP") !== 0) {
                $(article).find('h2:eq(1)').addClass(getFollowId());
                add_issue("The second H2 tag (##) of your Markdown file should be labeled with STEP (in all caps).", "", getFollowId());
            }
        }

        let checkImages = (article) => {
            $(article).find('img').each(function() {
                try {
                    if ($(this).attr('src').split('/')[$(this).attr('src').split('/').length - 2].indexOf("images") !== 0) {
                        add_issue("Your images must be in an <strong>images</strong> folder. Please rename the folder and update your Markdown.");
                        return false; // to break the each loop
                    }
                } catch(e) {
                    add_issue("Your images must be in an <strong>images</strong> folder. Please rename the folder and update your Markdown.");
                    return false;
                };
            });
        }

        let checkForCopyTag = (article) => {
            let count = 0;
            $(article).find('pre > code').each(function() {
                if($(this).find('.copy-code').length == 0) {
                    count += 1;
                    $(this).addClass(getFollowId());
                    add_issue("You have a code block (```) without a &lt;copy&gt; tag. Please review your Markdown and make the necessary changes.", "", getFollowId());
                }
            });
        }

        let checkCodeBlockFormat = (markdown) => {
            let count = (markdown.match(/\````/g) || []).length;
            if (count == 1) {
                add_issue("Your Markdown file has " + count + " codeblock with 4 (````). This should be changed to 3 (```). Please review your Markdown and make the necessary changes.")
            } else if (count > 1) {
                add_issue("Your Markdown file has " + count + " codeblocks with 4 (````). This should be changed to 3 (```). Please review your Markdown and make the necessary changes.")
            }
        }

        let updateCount = (article) => {
            $(error_div).find('#qa-reportheader').html('Total Issues: ' + $(error_div).find('li').length);
            if(!$(error_div).find('li').length) {
                $(error_div).find('#qa-reportbody').hide();
            } else {
                $(error_div).find('#qa-reportbody').show();
                if($(error_div).find('#qa-reportbody p').length === 0)
                    $(error_div).find('#qa-reportbody').append('<p>' + more_info + '</p>');
            }
        }

        let checkLinkExists = (article) => {
            $(article).find('a').each(function() {
                let url = $(this).attr('href');
                let url_text = $(this).text();
                urlExists(url, function(exists) {
                    if(!exists) {
                        $('a[href$="' + url + '"]').addClass('error ' + getFollowId());
                        add_issue("This URL may be broken: <a href='" + url + "' target='_blank'>" + url_text + "</a>", "major-error", getFollowId());
                        updateCount(article);
                    }
                });
            });
        }

        let checkImageExists = (article) => {
            $(article).find('img').each(function() {
                let url = $(this).attr('src');
                let url_text = $(this).attr('src').split('/')[$(this).attr('src').split('/').length - 1];
                urlExists(url, function(exists) {
                    if(!exists) {                                                                    ;
                        $('img[src$="' + url + '"]').addClass('error ' + getFollowId());
                        add_issue("The link to image <strong>" + url_text + "</strong> is broken.", "major-error", getFollowId())
                        updateCount(article);
                    }
                });
            });
        }

        let checkIfSectionExists = (article, section_name) => {
            if ($(article).find('div[name="' + alphaNumOnly(section_name) + '"]').length === 0)
                add_issue("You are missing <strong>" + section_name + "</strong> section.");
        }

        let checkIndentation = (article) => {
            $(article).find('section:not(:first-of-type)').each(function() {
                let tag_list = [];
                if($(this).find('h2').text().toUpperCase().trim().indexOf("STEP") == 0) {
                    $(this).children().each(function() {
                        tag_list.push($(this).prop('tagName'));
                    });

                    if($.inArray("UL", tag_list) !== -1 & $.inArray("OL", tag_list) == -1) {
                        add_issue("In section <strong>" + $(this).find('h2').text() + "</strong>, your steps are not numbered. Numbered steps should follow your STEP element.", "minor-error");
                        $(this).find('h2').addClass('format-error');
                    }

                    if($.inArray("PRE", tag_list) > $.inArray("OL", tag_list)) {
                        $(this).children('pre').addClass('format-error ' + getFollowId());
                        add_issue("Your codeblock is not indented correctly. Add spaces to indent your codeblock.", "minor-error", getFollowId());
                    }

                    $(this).find('img').each(function() {
                        if($(this).parent().parent().prop('tagName').indexOf("LI") == -1 && $(this).parent().parent().prop('tagName').indexOf("OL") == -1 && $(this).parent().parent().prop('tagName').indexOf("UL") == -1) {
                            // $(this).parents('section').children('h2').addClass('format-error');
                            $(this).addClass('format-error ' + getFollowId());
                            add_issue("The image <strong>" + $(this).attr('src').split('/')[$(this).attr('src').split('/').length - 1] + "</strong> is not aligned with your text blocks. Add spaces to indent your image.", "minor-error", getFollowId());
                        }
                    });
                }
            });
        }

        let getFollowId = () => 'error_' + $(error_div).find('li').length;

        checkH1(articleElement);
        checkForHtmlTags(markdownContent);
        checkImages(articleElement);
        checkCodeBlockFormat(markdownContent);
        checkSecondH2Tag(articleElement);
        checkForCopyTag(articleElement);
        if (!window.location.href.indexOf("localhost") && window.location.href.indexOf("127.0.0.1")) {
            checkLinkExists(articleElement);
        }
        checkImageExists(articleElement);
        checkIfSectionExists(articleElement, "Acknowledgements");
        checkIfSectionExists(articleElement, "See an issue?");
        checkIndentation(articleElement);
        updateCount(articleElement);

        return $(articleElement).prepend(error_div);
    }

    // picked up as it is from: https://www.w3schools.com/howto/howto_js_draggable.asp
    function dragElement(elmnt) {
      var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
      if (document.getElementById(elmnt.id + "header")) {
        // if present, the header is where you move the DIV from:
        document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;

        $('#qa-reportheader').dblclick(function() { // this line has been added to collapse qa report body
            $('#qa-reportbody').fadeToggle();
        });

      } else {
        // otherwise, move the DIV from anywhere inside the DIV:
        elmnt.onmousedown = dragMouseDown;
      }

      function dragMouseDown(e) {
        e = e || window.event;
        e.preventDefault();
        // get the mouse cursor position at startup:
        pos3 = e.clientX;
        pos4 = e.clientY;
        document.onmouseup = closeDragElement;
        // call a function whenever the cursor moves:
        document.onmousemove = elementDrag;
      }

      function elementDrag(e) {
        e = e || window.event;
        e.preventDefault();
        // calculate the new cursor position:
        pos1 = pos3 - e.clientX;
        pos2 = pos4 - e.clientY;
        pos3 = e.clientX;
        pos4 = e.clientY;
        // set the element's new position:
        elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
        elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
      }

      function closeDragElement() {
        // stop moving when mouse button is released:
        document.onmouseup = null;
        document.onmousemove = null;
      }
    }

}();
