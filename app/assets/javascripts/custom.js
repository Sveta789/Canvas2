jQuery(document).ready(function(){
    $('.spoiler-body').hide();
    $('.spoiler-title').click(function(){
        $(this).next().slideToggle();
    });
});

function showMenu(buttonID, menuID) {
    var menu = $('#'+ menuID);
    var btn = $('#'+ buttonID);
    var isClicked = btn.attr('clicked');
    if(isClicked == "false")
    {
        menu.css({transition:'0.5s',left:"-120px",opacity: "1"});
        btn.attr("clicked", "true");
    }
    else
    {
        menu.css({transition:'0.5s',left:"420px",opacity: "0"});
        btn.attr("clicked", "false");
    }
}


function toggleButtons(btn1, btn2)
{
    var currentBtn = $('#'+ btn1);
    var button2 = $('#'+ btn2);
    var isClicked = currentBtn.attr('clicked');
    if(isClicked == 'false')
    {
        currentBtn.attr("clicked", "true");
        currentBtn.css({opacity:'1'});
        button2.attr("clicked", "false");
        button2.css({opacity:'0.5'});
    }
}

function moveBlock(btnId,btn2Id,idOfBlock,infoArray)
{

    var block = $('#' + idOfBlock);
    var btn = $('#'+btnId);
    var btn2 = $('#'+btn2Id);
    if (btn.attr('clicked') == 'false' && btn2.attr('clicked') == 'false')
    {
        block.show('fast');
        btn.attr("clicked", "true");
        btn.css({background:'rgb(216,216,216)'});
        refreshBlock(idOfBlock,infoArray);
    }
    else if(btn.attr('clicked') == 'false' && btn2.attr('clicked') == 'true')
    {
        btn.attr("clicked", "true");
        btn2.attr("clicked", "false");
        refreshBlock(idOfBlock,infoArray);
        btn.css({background:'rgb(216,216,216)'});
        btn2.css({background:'rgb(255,255,255)'});
    }
    else if(btn.attr('clicked') == 'true' && btn2.attr('clicked') == 'false')
    {
        block.hide('fast');
        btn.attr("clicked", "false");
        btn.css({background:'rgb(255,255,255)'});
    }
}

function refreshBlock(idOfBlock, infoArray)
{
    var block = $('#' + idOfBlock);
    block.empty();
    for(var i = 0; i < infoArray.length;i++)
    {
        var row = $("<div class='one-information-row'></div>");
        row.text(infoArray[i]);
        block.append(row);
    }
}
