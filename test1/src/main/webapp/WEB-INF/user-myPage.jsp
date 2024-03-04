<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="js/jquery.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<title>마이 페이지</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<div>
			<fieldset>
			<ul>
				<li>
					<span>아이디 : </span>
					<input type="text" v-model="user.userId">
				</li>
				<li>
					<span>비밀번호 : </span>
					<input type="password" v-model="user.userPw"> 
				</li>
				<li>
					<span>비밀번호 확인 : </span>
					<input type="password" v-model="user.userPw2">
				</li>
				<li>
					<span>이름 : </span>
					<input type="text" v-model="user.name">
				</li>
				<li>
					<span>닉네임 : </span>
					<input type="text" v-model="user.nickName">
				</li>
				<li>
					
				</li>
			</ul>
			</fieldset>
		</div>	
	</div>
</body>
</html>
<script type="text/javascript">
var app = new Vue({
    el: '#app',
    data: {
    	
    }
    , methods: {
    	fnList: function() {
            var self = this;
            var nparmap = {
            		user :{
            			userId : "",
            			userPw : "",
            			userPw2 : "",
            			name : "",
            			nickName : "",
            			
            			
            			
            		}
            };
            $.ajax({
                url:"test.dox",
                dataType:"json",
                type: "POST",
                data: nparmap,
                success: function(data) {
                }
            });
        }
    }
    , created: function() {
    	var self = this;
		self.fnList();
	}
});
</script>