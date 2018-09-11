$(function() {

    //S4
    $('#screen4Image').css({
        right : -100,
        opacity : 0
    }).hide();

    $('#s4List').css({
        position : 'absolute',
        top : 400,
        opacity : 0
    });
    $('#s4TitleImage').css({
        top : -50,
        opacity : 0
    });

    //S5
    $('#screen5Image1').css({
        left : -80,
        opacity : 0
    }).hide();

    $('#screen5Image2').css({
        left : 0,
        opacity : 0
    }).hide();

    $('#screen5Image3').css({
        left : 140,
        opacity : 0
    }).hide();

    $('#s5TitleImage').css({
        top : -20,
        right : 40,
        opacity : 0
    });
    $('#s5Description').css({
        position : 'absolute',
        top : 360,
        left : 40,
        opacity : 0
    });

    //S6
    $('#s6TitleImage').css({
        top : 120,
        opacity : 0
    });
    $('#s6Description').css({
        position : 'absolute',
        top : 400,
        opacity : 0
    });

    //S6-1
    $('#screen6Image1').css({
        left : 0,
        top : 137,
        opacity : 0,
        zIndex : 2
    }).hide();

    //S6-2
    $('#screen6Image2').css({
        left : 200,
        top : 96,
        opacity : 0,
        zIndex : 3
    }).hide();

    //S6-3
    $('#screen6Image3').css({
        left : 350,
        top : 137,
        opacity : 0,
        zIndex : 2
    }).hide();
});

//S7
$('#screen7Image1').css({
    left : -80,
    opacity : 0
}).hide();

$('#screen7Image2').css({
    left : 0,
    opacity : 0
}).hide();

$('#screen7Image3').css({
    left : 140,
    opacity : 0
}).hide();

$('#s7TitleImage').css({
    top : -20,
    right : 40,
    opacity : 0
});
$('#s7Description').css({
    position : 'absolute',
    top : 360,
    left : 40,
    opacity : 0
});

var scrollSet = function() {
    var windowScrollTop = $(window).scrollTop();
    var screenHeight = $(window).height();
    //S4
    if (windowScrollTop > 600 && $('#screen4Image').data('animate') == "0") {
        $('#screen4Image').animate({
            'right' : '0px',
            'opacity' : 1
        }, 1000).show().data('animate', 1);

        $('#s4List').animate({
            'top' : 314,
            'opacity' : 1
        }, 1000).show().data('animate', 1);

        $('#s4TitleImage').animate({
            top : 0,
            opacity : 1
        }, 1000).show().data('animate', 1);
    }

    //S5
    if (windowScrollTop > 1200 && $('#screen5Image1').data('animate') == "0") {
        $('#screen5Image1').animate({
            left : '-52px',
            opacity : 1
        }, 1000).show().data('animate', 1);

        $('#s5TitleImage').animate({
            top : 0,
            opacity : 1
        }, 1000).show().data('animate', 1);

        $('#s5Description').animate({
            top : 332,
            opacity : 1
        });
    }

  //S6
    if (windowScrollTop > 1800 && $('#screen6Image').data('animate') == "0") {
        $('#screen6Image').animate({
            'right' : '0px',
            'opacity' : 1
        }, 1000).show().data('animate', 1);

        $('#s6List').animate({
            'top' : 314,
            'opacity' : 1
        }, 1000).show().data('animate', 1);

        $('#s6TitleImage').animate({
            top : 0,
            opacity : 1
        }, 1000).show().data('animate', 1);
    }
    
    
    //S7
    if (windowScrollTop > 2400 && $('#screen7Image1').data('animate') == "0") {
    	$('#screen7Image1').animate({
            left : '-52px',
            opacity : 1
        }, 1000).show().data('animate', 1);

    	$('#s7TitleImage').animate({
            top : 0,
            opacity : 1
        }, 1000).show().data('animate', 1);

        $('#s7Description').animate({
            top : 332,
            opacity : 1
        });
    
    }
    
    //S8
    if (windowScrollTop > 3000 && $('#screen8Image').data('animate') == "0") {
        $('#screen8Image').animate({
            'right' : '0px',
            'opacity' : 1
        }, 1000).show().data('animate', 1);

        $('#s8List').animate({
            'top' : 314,
            'opacity' : 1
        }, 1000).show().data('animate', 1);

        $('#s8TitleImage').animate({
            top : 0,
            opacity : 1
        }, 1000).show().data('animate', 1);
    }
};

setTimeout(function() {
    scrollSet();
    $(window).scroll(scrollSet);
}, 200);
