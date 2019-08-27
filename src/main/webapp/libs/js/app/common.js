// 
//  common.js
//  skywalk-er.com
//  
//  Created by silva on 2015-02-12.
//  Copyright 2015 silva. All rights reserved.
// 
// var URL = 'http://wx.localhost.com';
var URL = 'http://'+window.location.host;

var ua = navigator.userAgent.toLowerCase();
var sys = ua.match(/html5plus/);

if (sys != 'html5plus') {
	mui.openWindow = function openWindow(param,target,options) {
		if(param.target == '_blank'){
			window.open(param.url);
		}else{
			window.location.href = param.url;
		}
	}
}

mui.ready(function() {
	// 澶卞幓鐒︾偣琛ユ晳
	mui('.mui-inner-wrap').on('tap','input,textarea',function(){
		this.focus();
	});

	mui('#pullrefresh').scroll();
	mui('#slider').slider({
		interval: 3000
	});
	//渚ф粦瀹瑰櫒鐖惰妭鐐�
	var offCanvasWrapper = mui('#offCanvasWrapper');
	//涓荤晫闈㈠鍣�
	var offCanvasInner = offCanvasWrapper[0].querySelector('.mui-inner-wrap');
	//鑿滃崟瀹瑰櫒
	var offCanvasSide = document.getElementById("offCanvasSide");
	// var mask = mui.createMask();//callback涓虹敤鎴风偣鍑昏挋鐗堟椂鑷姩鎵ц鐨勫洖璋冿紱
	// mask.show();//鏄剧ず閬僵
	// mask.close();//鍏抽棴閬僵
	document.getElementById('offCanvasShow').addEventListener('tap', function() {
		offCanvasWrapper.offCanvas('show');
		Zepto('.mui-backdrop').show();
	});

	Zepto('.mui-backdrop').on('tap',function(){
		Zepto('.mui-backdrop').hide();
		offCanvasWrapper.offCanvas('close');
	})

	mui('.mui-table-view,.user-info,.tap-a').on('tap', 'a', function(e) {
		mui.openWindow({
			url: this.getAttribute('href'),
			id: 'info'
		});
	});
	mui('.mui-bar').on('tap','a',function(e){
		mui.openWindow({
			url: this.getAttribute('href'),
			id: 'info'
		});
	})
	/*寮瑰嚭璁㈠崟*/
	mui('.mui-content-padded').on('tap','#post-my-order',function(){
		mui('.mui-popover').popover('toggle');
	});
	mui('.mui-content-padded').on('tap','#order',function(){
		mui.openWindow({
			url: this.getAttribute('data-href'),
			id: 'order'
		});
	});
	/*鍏抽棴寮瑰嚭灞�*/
	mui('#popover').on('tap','.close-popover',function(){
		mui('.mui-popover').popover('toggle');
	});
	/*鎻愪氦璁㈠崟*/
	mui('#popover').on('tap','.btn-submit-order',function(){
		var name = Zepto('input[name="name"]').val(),
			phone = Zepto('input[name="phone"]').val(),
			person = Zepto('input[name="person"]').val(),
			child = Zepto('input[name="child"]').val(),
			message = Zepto('textarea[name="message"]').val(),
			product_id = Zepto('input[name="product_id"]').val();

		/*绌哄垽鏂�*/
		if(name.length==0){
			alert('璇峰厛杈撳叆鎮ㄧ殑灏婄О.');
			return false;
		}
		if(person.length==0){
			alert('鎮ㄥぇ绾︽湁澶氬皯浜哄弬鍔�?');
			return false;
		}
		/*妫€鏌ユ墜鏈哄彿鐮�*/
		if(phone.length==0)
		{
		   alert('璇疯緭鍏ユ墜鏈哄彿鐮侊紒');
		   phone.focus();
		   return false;
		}    
		if(phone.length!=11)
		{
		    alert('璇疯緭鍏ユ湁鏁堢殑鎵嬫満鍙风爜锛�');
		    phone.focus();
		    return false;
		}
		
		// var myreg = /^(((13[0-9]{1})|159|153)+\d{8})$/;
		var myreg = /1[3458]{1}\d{9}$/;
		if(!myreg.test(phone))
		{
		    alert('璇疯緭鍏ユ湁鏁堢殑鎵嬫満鍙风爜锛�');
		    phone.focus();
		    return false;
		}
			
		mui.ajax({
			type:'POST',
			url:URL+'/order/add_order',
			data:'product_id='+product_id+'&name='+name+'&phone='+phone+'&person='+person+'&child='+child+'&message='+message,
			success:function(json){
				alert(json.data);
				mui('.mui-popover').popover('toggle');
//				if(json.code == '200'){
//					mui('.mui-popover').popover('toggle');
//				}else{
//					mui('.mui-popover').popover('toggle');
//				}
			},
			error:function(json){
				alert(json.data);
				mui('.mui-popover').popover('toggle');
			}
		});
	});



	mui('a').on('tap','.reply',function(){
		mui('.reply-content')[0].style.display = 'block';
		document.getElementById('content').focus();
	})

	// mui('p').on('tap','.reply',tap_reply);
	// var tap_reply = function(){
	// 	mui('.reply-content')[0].style.display = 'block';
	// 	document.getElementById('content').focus();

	// 	var _num_flow = this.getAttribute('data-value');
	// 	if(_num_flow > 0){
	// 		Zepto('#reply_id').val(_num_flow);
	// 		Zepto('.reply-content-tit').html('鍥炲'+_num_flow+'妤�');
	// 	}else{
	// 		Zepto('.reply-content-tit').html('鍥炲');

	// 	}
	// };

	mui('p').on('tap','.reply-close',function(){
		mui('.reply-content')[0].style.display = 'none';
		Zepto('.reply-content-tit').html('鍥炲');
		Zepto('#content').val('')
	})
	mui('p').on('tap','.reply-submit',function(){
		var _uid = Zepto('#uid').val(),
			_community_id = Zepto('#community_id').val(),
			_cid = Zepto('#cid').val(),
			_reply_id = Zepto('#reply_id').val(),
			_unsign = Zepto('#unsign').attr("checked"); //Zepto('#unsign').val(),
			_content = Zepto('#content').val(),
			_username = Zepto('#username').val();

		if(_content == undefined || _content == ''){
			alert('璇寸偣浠€涔堝啀鎻愪氦鍚-^');
			return false;
		}
		mui.ajax({
			type:'POST',
			url:URL+'/community/post_reply',
			data:'user_id='+_uid+'&username='+_username+'&cid='+_cid+'&content='+_content+'&community_id='+_community_id+'&reply_id='+_reply_id+'&unsign='+_unsign,
			success:function(json){
				// alert(json.data);
				// mui('.mui-popover').popover('toggle');
				if(json.code == '200'){
					alert(json.data);
					mui('.mui-popover').popover('toggle');
				}else{
					alert(json.data);
					mui('.mui-popover').popover('toggle');
				}
			},
			error:function(json){
				alert(json.data);
			}
		});

		mui('.reply-content')[0].style.display = 'none';
		Zepto('.reply-content-tit').html('鍥炲');
	});
	mui('.font-face').on('tap','span',function(){
		Zepto('#content').val(Zepto('#content').val()+Zepto(this).html());
		console.log(Zepto('#content').val());
	});

	mui('.mui-content-padded').on('tap','h5.show-content',function(){
		var cdt = Zepto('.content-detail');
		cdt.find('img').attr({
			width: '',
			height: ''
		}).css({
			width: '',
			height: ''
		});;
		if(cdt.height() != 200){
			Zepto('.content-detail').css({
				height: '200px'
			});
			Zepto('h5.show-content').html('灞曞紑绾胯矾璇︾粏浠嬬粛');
		}else{
			Zepto('.content-detail').css({
				height: 'auto'
			});
			Zepto('h5.show-content').html('鏀惰捣绾胯矾璇︾粏浠嬬粛');
		}
		
	});

	// 寰俊鏀粯
	Zepto('.weixin-pay').on('tap', function() {
		var trust = Zepto('input[name="trust"]').val();
		var phone = Zepto('input[name="phone2"]').val();
		var name = Zepto('input[name="nickname2"]').val();

		var person = Zepto('input[name="person2"]').val(),
			child = Zepto('input[name="child2"]').val(),
			message = Zepto('textarea[name="message2"]').val(),
			product_id = Zepto('input[name="product_id"]').val();

		if(trust == 0){
			/*妫€鏌ユ墜鏈哄彿鐮�*/
			if(phone.length==0)
			{
			   alert('璇疯緭鍏ユ墜鏈哄彿鐮侊紒');
			   phone.focus();
			   return false;
			}
			if(phone.length!=11)
			{
			    alert('璇疯緭鍏ユ湁鏁堢殑鎵嬫満鍙风爜锛�');
			    phone.focus();
			    return false;
			}
			/*绌哄垽鏂�*/
			if(name.length==0){
				alert('璇疯緭鍏ユ樀绉�');
				return false;
			}
			if(person.length==0){
				alert('鎮ㄥぇ绾︽湁澶氬皯浜哄弬鍔�?');
				return false;
			}
			
			
			// var myreg = /^(((13[0-9]{1})|159|153)+\d{8})$/;
			var myreg = /1[3458]{1}\d{9}$/;
			if(!myreg.test(phone))
			{
			    alert('璇疯緭鍏ユ湁鏁堢殑鎵嬫満鍙风爜锛�');
			    phone.focus();
			    return false;
			}
			
		}

		mui.ajax({
			type:'POST',
			url:URL+'/order/add_order',
			data:'product_id='+product_id+'&name='+name+'&phone='+phone+'&person='+person+'&child='+child+'&message='+message+'&trust='+trust,
			success:function(json){
				alert(json.data);
				// mui('.mui-popover').popover('toggle');
				if(json.code == '200'){
					//mui('.mui-popover').popover('toggle');
					window.location.href="http://m.skywalk-er.com/payment/weixin/order_id/"+json.order_id;
				}else{
					mui('.mui-popover').popover('toggle');
				}
			},
			error:function(json){
				alert(json.data);
				mui('.mui-popover').popover('toggle');
			}
		});

	});

	/* 閫€鍑虹櫥褰� */
	mui('.mui-content-padded').on('tap','.btn-logout',function(){
		window.location.href="/member/public/logout";
	});

	

});