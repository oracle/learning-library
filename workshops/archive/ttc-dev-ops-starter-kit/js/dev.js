var labGuide = angular.module('labGuide', ['ngMaterial', 'ngSanitize']);

labGuide.config(function ($mdThemingProvider) {
    var whiteBackground = $mdThemingProvider.extendPalette('grey', {
        '50': '#fefefe'
    });
    $mdThemingProvider.definePalette('whiteBackground', whiteBackground);
    $mdThemingProvider.theme('default')
        .primaryPalette('blue')
        .accentPalette('orange')
        .warnPalette('red')
        .backgroundPalette('whiteBackground');
    $mdThemingProvider.theme('ttc')
        .primaryPalette('blue')
        .accentPalette('light-blue')
        .warnPalette('red')
        .backgroundPalette('whiteBackground');
    $mdThemingProvider.alwaysWatchTheme(true);
});

labGuide.controller('labGuideController', ['$scope', '$http', '$mdSidenav', '$sanitize', '$sce', '$mdDialog' 
    , function ($scope, $http, $mdSidenav, $sanitize, $sce, $mdDialog) {
        $scope.theme = 'default';
        $scope.selection = {
            "lab": false
        };
//        READ MANIFEST - THEME, INTERACTIVE, MENU
        $http.get('manifest.json').then(function (res) {
            $scope.manifest = res.data;
            console.log("json",$scope.manifest)
            if($scope.manifest.workshop.interactive){
               $scope.enableInteractive = true;
               $scope.interactive = {
                    src: $scope.manifest.workshop.interactive
                    , title: "Interactive Tour"
                };
            }
            
            if($scope.manifest.workshop.theme){
                console.log("Theme selected",$scope.manifest.workshop.theme);
                if($scope.manifest.workshop.theme == 'ttc'){
                    $scope.theme = 'ttc';
                }
            }
        }, function (msg) {
            console.log('Error getting manifest.json!');
            console.log(msg);
        });
        $scope.trustSrc = function (src) {
            return $sce.trustAsResourceUrl(src);
        }
        $scope.loadContent = function (page) {
            $http.get(page).then(function (res) {
                var converter = new showdown.Converter()
                    , text = res.data
                    , html = converter.makeHtml(text);
                $scope.htmlContent = html;
                page.htmlContent = html;
                $scope.selection.lab = true;
                setTimeout(function () {
                    $("#labguide h2").next("h3").addClass("first-in-section");
                    $("#labguide h3").nextUntil("#labguide h1, #labguide h2, #labguide h3").hide();
                    $("#labguide h3").addClass('plus');
                    $("#labguide h3").click(function (e) {
                        var fadeOutStep = function (step) {
                            $(step).nextUntil("#labguide h1, #labguide h2, #labguide h3").fadeOut();
                            $(step).addClass('plus');
                            $(step).removeClass('minus');
                        };
                        var fadeInStep = function (step) {
                            $(step).nextUntil("#labguide h1, #labguide h2, #labguide h3").fadeIn();
                            $(step).addClass('minus');
                            $(step).removeClass('plus');
                        };
                        if (e.offsetY < 0) { //user has clicked above the H3, in the expand/collapse all button
                            if ($(this).hasClass('first-in-section') && $(this).hasClass('plus')) {
                                fadeInStep($(this));
                                $(this).nextUntil("#labguide h1, #labguide h2", "h3").each(function (i, e) {
                                    return fadeInStep(e);
                                });
                            }
                            else if ($(this).hasClass('first-in-section') && $(this).hasClass('minus')) {
                                fadeOutStep($(this));
                                $(this).nextUntil("#labguide h1, #labguide h2", "h3").each(function (i, e) {
                                    return fadeOutStep(e);
                                });
                            }
                        }
                        else { //user has clicked in the H3, only work on this step
                            if ($(this).hasClass('plus')) {
                                fadeInStep($(this));
                            }
                            else if ($(this).hasClass('minus')) {
                                fadeOutStep($(this));
                            }
                        }
                    });
                }, 0);
            }, function (msg) {
                console.log('Error getting lab guide markdown!');
                console.log(msg);
            });
        }
        $scope.getLabGuide = function (lab) {
            if (lab.htmlContent == null) {
                $scope.loadContent(lab.filename);
            }
            else {
                $scope.htmlContent = lab.htmlContent;
                $scope.selection.lab = true;
            }
            setTimeout(function () {
                if (lab.filename === 'README.md') {
                    $("#labguide a").each(function () {
                        if (this.href.endsWith('.md')) {
                            $(this).on("click", function (event) {
                                event.preventDefault();
                                $scope.getLabGuide({
                                    filename: this.href
                                });
                            });
                        }
                    })
                }
            }, 500);
        }
        $scope.toggleLeft = function () {
            $mdSidenav('left').toggle();
        };
        $scope.close = function () {
            $mdSidenav('left').close();
        };
        $scope.cancel = function () {
            $mdDialog.cancel();
        };
        $scope.showInteractive = function (ev) {
            $mdDialog.show({
                contentElement: '#interactiveDialog'
                , parent: angular.element(document.body)
                , targetEvent: ev
                , clickOutsideToClose: true
                , fullscreen: true
            });
        };
        //upon page load, display Home
        $scope.getLabGuide({
            filename: 'Home.md'
        });
    }]);