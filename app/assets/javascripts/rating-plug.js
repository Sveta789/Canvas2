//
// var RatingBase = function(){
//     this.className = "rating-base "
//     this.jQModel;
//     this.getDiv = function(){
//         return "<div></div>";
//     };
//
//     this.createJQModel = function(){
//         this.jQModel = $(this.getDiv());
//     }
//
//     this.getJQObject = function(){
//         return this.jQModel;
//     }
//
//     this.getClassName = function(){
//         return this.className;
//     }
// }
//
// var parent = new RatingBase();
//
// var Element = function(src, clicked){
//     RatingBase.apply(this,arguments);
//     var self = this;
//     this.className = "rating-element " + parent.getClassName() + " ";
//     this.isClicked = (clicked != undefined) ? clicked : false;
//     this.id = 0;
//     this.getDiv = function(){
//         return "<div class = '" + self.className + ((self.isClicked) ? " rating-element-clicked' " : "'") + "id = " + self.id + "> </div> \n";
//     }
//
//
//     this.setClicked = function(){
//         self.isClicked = true;
//     }
//
//     this.setId = function(num){
//         if(!isNaN(num)){
//             self.id = num;
//         }
//     }
// }
//
// var Rating = function(action, answered, rating, average_rating ,votes){
//     RatingBase.apply(this,arguments);
//     var self = this;
//     this.elemsCount = 10;
//     this.action = action;
//     this.className = "rating-block " + parent.getClassName() + " ";
//     this.hasAnswer = answered;
//     this.rating = rating;
//     this.average_rating = average_rating;
//     this.elemsArray = [];
//     this.votes = votes;
//     this.getDiv = function(){
//         var res = "<div class = " + self.className + ">";
//         for(var i = 0; i < this.elemsCount; i++){
//             var elem = new Element("");
//             if(this.hasAnswer && i<this.rating){
//                 elem.setClicked();
//             }
//             elem.setId(i);
//             elem.createJQModel();
//             this.elemsArray.push(elem);
//             res += elem.getDiv();
//         }
//         res += "<div class = votes> Всего голосов: " + this.votes + "</div>";
//         res += "<div class = average-rating-block> Средняя оценка: " + this.average_rating + "</div>";
//         res += "<div class = your-rating-block> Вы поставили: " + ((answered) ? this.rating : "Еще нет оценки") + "</div>";
//         res +=  "</div>";
//         return res;
//     }
//
//     this.setAnswered = function(){
//         self.hasAnswer = true;
//     }
//
//     this.setRating = function(num){
//         self.rating = num;
//     }
//
//     this.createJQModel();
//
// }
//
// var postRatingData = function(number, userId, portfolioId) {
//     var data =  {rating:{rating:number,user_id:userId,portfolio_id: portfolioId}}
//     $.ajax({
//         type: "POST",
//         url: "ratings/onPluginClick",
//         contentType: "application/json; charset=utf-8",
//         dataType: "json",
//         data: JSON.stringify(data),
//         success: function(data) {
//             alert('success!');
//         }
//     });
// }
//
// var bindHandlers = function(element){
//     element.on('mouseover', '.rating-element' ,function(){
//         var index = $(this).attr("id");
//         for(var i = 0; i <= index;i++){
//             $('.rating-element:nth-of-type(' + (i+1) + ')').addClass('rating-element-hovered');
//         }
//     })
//     element.on('mouseleave','.rating-element' ,function(){
//         var index = $(this).attr("id");
//         for(var i = 0; i <= index;i++){
//             $('.rating-element:nth-of-type(' + (i+1) + ')').removeClass('rating-element-hovered');
//         }
//     })
//
//     element.on('click', '.rating-element',function(){
//         var ratingWrap =  $('#rating-wrapper');
//         var index = parseInt($(this).attr("id")) + 1;
//         var votes = parseInt($('#rating-wrapper').attr("votes"));
//         var average_rating = parseFloat($('#rating-wrapper').attr("average-rating"));
//         var full_rating = average_rating * votes;
//         if($(this).attr("answered") == false) {
//             full_rating += index;
//             votes++;
//             average_rating = full_rating/votes;
//         }
//         else{
//             full_rating = average_rating * (votes-1) + index;
//             average_rating = full_rating/votes;
//         }
//         var user_id = parseInt(ratingWrap.attr("user_id"));
//         var portfolio_id = parseInt(ratingWrap.attr("portfolio_id"));
//         postRatingData(index,user_id,portfolio_id);
//         ratingBlock = new Rating("/rating", true, index, average_rating,votes);
//         $('#rating-wrapper .rating-block').replaceWith(ratingBlock.getJQObject());
//     });
// }
//
// var ready = function (){

//     var element = $('#rating-wrapper');
//     ratingBlock = new Rating("/rating", element.attr("answered"), element.attr("rating"), element.attr("average-rating"),element.attr("votes"));
//     ratingBlock.getJQObject().appendTo(element);
//     bindHandlers(element);
// };
//
// $(document).on('turbolinks:load', ready);
//
//
//
