
var RatingBase = function(){
    this.className = "rating-base "
    this.jQModel;
    this.getDiv = function(){
        return "<div></div>";
    };

    this.createJQModel = function(){
        this.jQModel = $(this.getDiv());
    }

    this.getJQObject = function(){
        return this.jQModel;
    }

    this.getClassName = function(){
        return this.className;
    }
}

var parent = new RatingBase();

var Element = function(src, clicked){
    RatingBase.apply(this,arguments);
    var self = this;
    this.className = "rating-element " + parent.getClassName() + " ";
    this.isClicked = (clicked != undefined) ? clicked : false;
    this.id = 0;
    this.getDiv = function(){
        return "<div class = '" + self.className + ((self.isClicked) ? " rating-element-clicked' " : "'") + "id = " + self.id + "> </div> \n";
    }


    this.setClicked = function(){
        self.isClicked = true;
    }

    this.setId = function(num){
        if(!isNaN(num)){
            self.id = num;
        }
    }
}

var Vote = function(votes,answered){
    RatingBase.apply(this,arguments);
    var self = this;
    this.className = "votes-block " + parent.getClassName() + " ";
    this.votes = votes;
    this.hasAnswer = answered;
    this.getDiv = function(){
        return "<div class = '" + self.className + "'>" + ((!this.hasAnswer) ?  "Проголосовало: " + self.votes : "Спасибо за отзыв!" ) +"</div>";
    }
    this.incVotes = function(){
        self.votes += 1;
    }

}

var Rating = function(action, answered, rating, votes){
    RatingBase.apply(this,arguments);
    var self = this;
    this.elemsCount = 10;
    this.action = action;
    this.className = "rating-block " + parent.getClassName() + " ";
    this.hasAnswer = answered;
    this.rating = rating;
    this.elemsArray = [];
    this.votes = new Vote(votes,answered);
    this.getDiv = function(){
        var res = "<div class = " + self.className + ">";
        for(var i = 0; i < this.elemsCount; i++){
            var elem = new Element("");
            if(this.hasAnswer && i<this.rating){
                elem.setClicked();
            }
            elem.setId(i);
            elem.createJQModel();
            this.elemsArray.push(elem);
            res += elem.getDiv();
        }
        res += this.votes.getDiv();
        res +=  "</div>";
        return res;
    }

    this.setAnswered = function(){
        self.hasAnswer = true;
    }

    this.setRating = function(num){
        self.rating = num;
    }

    this.createJQModel();

}

var postRatingData = function(number, userId, portfolioId) {
    var data =  {rating:{rating:number,user_id:userId,portfolio_id: portfolioId}}
    $.ajax({
        type: "POST",
        url: "ratings/onPluginClick",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(data),
        success: function(data) {
            alert('success!');
        }
    });
}

var bindHandlers = function(element){
    element.on('mouseover', '.rating-element' ,function(){
        var index = $(this).attr("id");
        for(var i = 0; i <= index;i++){
            $('.rating-element:nth-of-type(' + (i+1) + ')').addClass('rating-element-hovered');
        }
    })
    element.on('mouseleave','.rating-element' ,function(){
        var index = $(this).attr("id");
        for(var i = 0; i <= index;i++){
            $('.rating-element:nth-of-type(' + (i+1) + ')').removeClass('rating-element-hovered');
        }
    })

    element.on('click', '.rating-element',function(){
        var ratingWrap =  $('#rating-wrapper');
        var index = parseInt($(this).attr("id")) + 1;
        var user_id = parseInt(ratingWrap.attr("user_id"));
        var portfolio_id = parseInt(ratingWrap.attr("portfolio_id"));
        var answer;
        postRatingData(index,user_id,portfolio_id);
        /*
        $.ajax(ratingBlock.action).done(function(json){
            answer = json;
        }).fail(function(){
            $("#rating-wrapper").append("<div>NEA!!</div>");
        });
        alert(answer);
        */
        //ratingWrap.attr("answered", answer.answered);
        //ratingWrap.attr("rating", answer.rating);
        //ratingWrap.attr("votes", answer.votes);
        ratingBlock = new Rating("/rating", ratingWrap.attr("answered"), index, ratingWrap.attr("votes"));
        $('#rating-wrapper .rating-block').replaceWith(ratingBlock.getJQObject());
    });
}

/*
$(document).ready(
    function(){
        var ratingWrap =  $('#rating-wrapper');
        ratingBlock = new Rating("/rating", ratingWrap.attr("answered"), ratingWrap.attr("rating"), ratingWrap.attr("votes"));
        ratingBlock.getJQObject().appendTo("#rating-wrapper");
        var element = $("#rating-wrapper");
        bindHandlers(element);
    })
    */

var ready = function (){
    var element = $('#rating-wrapper');
    ratingBlock = new Rating("/rating", element.attr("answered"), element.attr("rating"),element.attr("votes"));
    ratingBlock.getJQObject().appendTo(element);
    bindHandlers(element);
};

$(document).on('turbolinks:load', ready);



