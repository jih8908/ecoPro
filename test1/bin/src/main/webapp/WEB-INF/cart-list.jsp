<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>장바구니 목록</title>
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="../css/bootstrap-min.css" type="text/css">
    <link rel="stylesheet" href="../css/font-awesome-min.css" type="text/css">
    <link rel="stylesheet" href="../css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="../css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="../css/jquery-ui-min.css" type="text/css">
    <link rel="stylesheet" href="../css/owl-carousel-min.css" type="text/css">
    <link rel="stylesheet" href="../css/slicknav-min.css" type="text/css">
    <link rel="stylesheet" href="../css/style2.css" type="text/css">
	<%-- <jsp:include page="/layout/header.jsp"></jsp:include> --%>
</head>
<body>
<div id="app">
	 <div id="preloder">
        <div class="loader"></div>
    </div>
    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2> 장바구니</h2>
                        <div class="breadcrumb__option">
                            <a href="javascript:;" @click="fnHome">Home</a>
                            <span>장바구니</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Shoping Cart Section Begin -->
    <section class="shoping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th class="shoping__product">제품</th>
                                    <th>가격</th>
                                    <th>수량</th>
                                    <th>총 금액</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="shoping__cart__item">
                                        <img src="../img/cart/cart-1.jpg" alt="">
                                        <h5>{{ product.itemName }}</h5>
                                    </td>
                                    <td class="shoping__cart__price">
                                        ₩{{ product.price }}
                                    </td>
                                    <td class="shoping__cart__quantity">
                                        <div class="quantity">
                                            <div class="pro-qty">
                                                <input type="text" value="1">
                                            </div>
                                        </div>
                                    </td>
                                    <td class="shoping__cart__total">
                                        ₩{{ payment.sumPrice }}
                                    </td>
                                    <td class="shoping__cart__item__close">
                                        <span class="icon_close"></span>
                                    </td>
                                </tr>
                                
                              
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__btns">
                        <a href="javascript:;" @click="fnProductList" class="primary-btn cart-btn">쇼핑계속하기</a>
                        <a href="javascript:;" @click="fnRefresh" class="primary-btn cart-btn cart-btn-right"><span class="icon_loading"></span>
                           장바구니 새로고침</a>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="shoping__checkout">
                        <h5>주문자 정보</h5>
                        <ul>
                            <li>이름<span>{{user.name}}</span></li>
                            <li>핸드폰 번호 : <span>{{user.phone1}} - {{user.phone2}} -
							{{user.phone3}}</span></li>
                            <li>이메일 : <span>{{user.email}}</span></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="shoping__checkout">
                        <h5>총 금액</h5>
                        <ul>
                            <li>금액 <span>₩{{product.price}}</span></li>
                            <li>할인 <span>₩{{product.sRate}}</span></li>
                            <li>총 금액 <span>₩{{payment.sumPrice}}</span></li>
                        </ul>
                        <a href="javascript:;" @click="fnKakaoPay" class="primary-btn">계속해서 진행하기</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shoping Cart Section End -->
    
	
	
</div>
	<!-- Js Plugins -->
    <script src="../js/jquery-3.3.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery.nice-select.min.js"></script>
    <script src="../js/jquery-ui.min.js"></script>
    <script src="../js/jquery.slicknav.js"></script>
    <script src="../js/mixitup.min.js"></script>
    <script src="../js/owl.carousel.min.js"></script>
    <script src="../js/main.js"></script>
</body>
</html>

<script type="text/javascript">
var app = new Vue({
    el: '#app',
    data: {
    	user: {},
        cartItems: [],
        product : {}
    },
    computed: {
        payment: function() {
            let sumPrice = 0;
            let discount = 0;
            this.cartItems.forEach(item => {
                sumPrice += item.price * item.quantity;
                discount += item.price * item.sRate * item.quantity;
            });
            let finalPrice = sumPrice - discount;
            return {
                sumPrice: sumPrice,
                discount: discount,
                finalPrice: finalPrice
            };
        }
    },
    methods: {
        fnCartList: function() {
            var self = this;
            $.ajax({
                url: "/cart/list.dox",
                dataType: "json",
                type: "POST",
                data: {},
                success: function(data) {
                    self.cartItems = data; 
                },
                error: function(error) {
                    console.log("Error fetching cart list:", error);
                }
            });
        	},
        	addCartItem: function(itemName) {
                var self = this;
                $.ajax({
                    url: "/cart/add.dox",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({ itemName: itemName, quantity: quantity }), //1
                    success: function(response) {
                        alert(response);
                       
                    },
                    error: function(error) {
                        console.log("Error adding item:", error);
                    }
                });
            },
            removeCartItem: function(itemName) {
                var self = this;
                $.ajax({
                    url: "/cart/remove.dox",
                    type: "POST",
                    data: { itemName: itemName },
                    success: function(response) {
                        alert(response);
                        
                    },
                    error: function(error) {
                        console.log("Error removing item:", error);
                    }
                });
            },
        fnProductList: function() {
        	$.pageChange("/productList.do", {});
        	},
        fnHome: function() {
        	$.pageChange("/main.do", {});
        	},
        fnKakaoPay: function() {
    	    $.pageChange("/KakaoPay.do", {});
    		}
	   	
	    },
    created: function() {
        this.fnCartList(); 
    }
});
</script>
