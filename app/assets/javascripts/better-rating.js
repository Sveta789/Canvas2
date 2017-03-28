var BetterRating = function (id, userId, portfolioId) {
    var self = this;
    this.mId = id;
    this.mAvgRate = 0;
    this.mUserRate = 0;
    this.mVotes = 0;
    this.mUserId = userId;
    this.mPortfolioId = portfolioId;
    this.mElements = [];
    this.mElem = this.createWrapper();
    this.initElements(this.mElem);

    this.mElem.on( "rating:clicked", function(event, index) {
        self.mElements.forEach(function(item, i, arr) {
            if(i <= index - 1){
                item.setActive(true);
            }else{
                item.setActive(false);
            }
        });
        self.initLabels($('#' + self.mId));
    });

    this.mElem.on( "rating:hovered", function(event, index) {
        self.mElements.forEach(function(item, i, arr) {
            if(i <= index){
                item.mElem.addClass('rating-element-hovered');
            }
        });
    });

    this.mElem.on( "rating:leaved", function(event, index) {
        self.mElements.forEach(function(item, i, arr) {
            if(i <= index){
                item.mElem.removeClass('rating-element-hovered');
            }
        });
    });


    this.initPlugin();
    this.initLabels($('#' + this.mId));
};

BetterRating.prototype.initPlugin = function () {
    var self = this;
    var data = {rating: {user_id: this.mUserId, portfolio_id: this.mPortfolioId}};
    $.ajax({
        type: "POST",
        url: "ratings/get_rating_info",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(data),
        complete: function (data) {
            self.updateFields(data);
        }
    })
}


BetterRating.prototype.initElements = function (wrap) {
    var self = this;
    this.mElements.length = 0;
    for (i = 0; i < 10; i++) {
        var e = new Element(i, this, false);
        this.mElements.push(e);
        wrap.append(e.mElem);
    }
};

BetterRating.prototype.initLabels = function (wrap) {
    var self = this;
    $('.rating-labels').remove();
    var labels = $('<div class="rating-labels"></div>');
    labels.append($('<div> Средняя Оценка:' + this.mAvgRate  + '</div>'));
    labels.append($('<div> Ваша Оценка:' + this.mUserRate + '</div>'));
    labels.append($('<div> Всего Голосов:' + this.mVotes + '</div>'));
    wrap.append(labels);
};

BetterRating.prototype.updateFields = function (data) {
    this.mUserRate = data.responseJSON.rating;
    this.mAvgRate = data.responseJSON.average;
    this.mVotes = data.responseJSON.votes;
    this.mElem.trigger('rating:clicked', [(this.mUserRate != "Не голосовал") ? this.mUserRate : Math.round(this.mAvgRate)]);
}

BetterRating.prototype.createWrapper = function () {
    var outer_wrapper = $('#' + this.mId);
    var inner_wrapper = $('<div class = "rating-inner"></div>');
    outer_wrapper.append(inner_wrapper);
    return inner_wrapper;
}

BetterRating.prototype.getId = function () {
    return this.mId;
}

BetterRating.prototype.postRatingData = function (index) {
    var self = this;
    var data = {rating: {rating: index, user_id: this.mUserId, portfolio_id: this.mPortfolioId}};
    $.ajax({
        type: "POST",
        url: "ratings/onPluginClick",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(data),
        success: function (data) {
            alert('Ваша оценка учтена!');
        },
        complete: function (data) {
            self.updateFields(data);
        }
    })
}

var Element = function (orderNum, parent, active) {
    this.mOrderNum = orderNum;
    this.mParent = parent;
    this.mActive = active;
    this.mElem = $('<div class = "rating-element"></div>');
    var self = this;
    this.mElem.on('click', function () {
        self.mParent.postRatingData(self.mOrderNum + 1);
    });
    this.mElem.on('mouseover',function () {
        self.mParent.mElem.trigger('rating:hovered', [self.mOrderNum]);
    });
    this.mElem.on('mouseleave',function () {
        self.mParent.mElem.trigger('rating:leaved', [self.mOrderNum]);
    });
};


Element.prototype.setActive = function (state) {
    this.mActive = state;
    if(this.mActive) {
        this.mElem.toggleClass('rating-element-active', true);
    }else{
        this.mElem.toggleClass('rating-element-active', false);
    }
};

