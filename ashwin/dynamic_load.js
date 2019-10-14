$(function () {
    $.getJSON("manifest.json", function (json) {
        var myUrl = json.workshop.filename;
        var tmpElement;
        $.get(myUrl, function (markdown) {
            tmpElement = document.createElement('article');
            $(tmpElement).html(new showdown.Converter().makeHtml(markdown));

            //replacing the h1 title in the OBE
            $("#content>h1").html($("#content>h1").html().replace($("#content>h1").text(), $(tmpElement).find('h1').text()));
            $(tmpElement).find('h1').remove();

            //Adding class, width, and height to the h2 title
            $(tmpElement).find('h2>img').addClass('num_circ');
            $(tmpElement).find('h2>img').attr('height', '32');
            $(tmpElement).find('h2>img').attr('width', '32');

            //Wrapping with figure, adding figcaption to all those images that have title in the MD
            $(tmpElement).find("img").each(function () {
                if ($(this).attr("title") !== undefined) {
                    $(this).wrap("<figure></figure>");
                    var filename = $(this).attr("src").split("/").pop().split('.').shift();
                    $(this).parent().append('<figcaption><a href="files/' + filename + '.txt">Description of illustration [' + filename + ']</figcaption>');
                }
            });

            //moving the pre elements a layer up for stylesheet matching
            var all_pre = $(tmpElement).find('pre');
            $(all_pre).appendTo($(all_pre).prev()); 
            
            //changing document head based on the manifest
            document.title = json.workshop.title;
            document.getElementsByTagName('meta').contentid.content = json.workshop.contentid;
            document.getElementsByTagName('meta').description.content = json.workshop.description;
            document.getElementsByTagName('meta').partnumber.content = json.workshop.partnumber;
            document.getElementsByTagName('meta').publisheddate.content = json.workshop.publisheddate;
        })
        .done(function() {
            $("#bookContainer").html(tmpElement);
            $.getScript("https://docs.oracle.com/en/cloud/paas/nosql-cloud/gsans/js/leftnav.js");
        });
    });
});
