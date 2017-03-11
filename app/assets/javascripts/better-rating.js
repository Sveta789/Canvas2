var BetterRating = function (id, average_rate, user_rate, votes, user_voted, userId, portfolioId) {
    this.mId = id;
    this.mAvgRate = average_rate;
    this.mUserRate = user_rate;
    this.mTempAvgRate = null;
    this.mVotes = votes;
    this.mUserVoted = user_voted;
    this.mUserId = userId;
    this.mPortfolioId = portfolioId;
    this.mElements = [];
    this.mElementsInDom = [];
    var wrapper = this.createWrapper();
    this.initElements(wrapper);
    this.initLabels($('#' + this.mId));
    console.log('RatingPlug created');
}

BetterRating.prototype.initElements = function (wrap) {
    var self = this;
    this.mElements.length = 0;
    this.mElementsInDom.length = 0;
    for (i = 0; i < 10; i++) {
        var active = ((this.mUserVoted) ? this.mUserRate : this.mAvgRate) >= i + 1;
        var e = new Element(i, this, active);
        this.mElements.push(e);
        var eInDom = $('<div class = "rating-element"></div>');
        this.mElementsInDom.push(eInDom);
        if (this.mElements[i].mActive) {
            this.mElementsInDom[i].toggleClass('rating-element-active');
        }
        wrap.append(eInDom);
    }
    this.mElementsInDom.forEach(function (eInDom, index, elems) {
        eInDom.on('click', function () {
            self.mElements[index].handleClick();
        });
        eInDom.on('mouseover',function () {
            for (var i = 0; i <= index; i++) {
                self.mElementsInDom[i].addClass('rating-element-hovered');
            }
        });
        eInDom.on('mouseleave',function () {
            for (var i = 0; i <= index; i++) {
                self.mElementsInDom[i].removeClass('rating-element-hovered');
            }
        });
    });
}

BetterRating.prototype.initLabels = function (wrap) {
    var self = this;
    $('.rating-labels').remove();
    var labels = $('<div class="rating-labels"></div>');
    labels.append($('<div> Средняя Оценка:' + ((this.mTempAvgRate == null) ? Math.ceil(this.mAvgRate) : Math.ceil(this.mTempAvgRate)) + '</div>'));
    labels.append($('<div> Ваша Оценка:' + ((this.mUserVoted) ? this.mUserRate : 'Не Голосовал') + '</div>'));
    labels.append($('<div> Всего Голосов:' + this.mVotes + '</div>'));
    wrap.append(labels);
}

BetterRating.prototype.wasClicked = function (number) {
    var wrap = $('.rating-inner');
    wrap.empty();
    this.mUserRate = number + 1;
    if (!this.mUserVoted) {
        this.mUserVoted = true;
        this.mVotes += 1;
    }
    this.mTempAvgRate = (this.mVotes > 1) ? (this.mAvgRate + this.mUserRate) / 2 : this.mUserRate;
    this.postRatingData();
    this.initElements(wrap);
    this.initLabels($('#' + this.mId));
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

BetterRating.prototype.postRatingData = function () {
    var data = {rating: {rating: this.mUserRate, user_id: this.mUserId, portfolio_id: this.mPortfolioId}};
    $.ajax({
        type: "POST",
        url: "ratings/onPluginClick",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(data),
        success: function (data) {
            alert('success!');
        }
    });
}

var Element = function (orderNum, parent, active) {
    this.mOrderNum = orderNum;
    this.mParent = parent;
    this.mActive = active;
}

Element.prototype.handleClick = function () {
    this.mActive = !this.mActive;
    this.mParent.wasClicked(this.mOrderNum);
}

