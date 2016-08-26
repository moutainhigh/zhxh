/*
2016-7-28
renjiahui
众恒-JS
*/

$(document).ready(function(){


	//搜索框 显示 隐藏
	var ss = true;
	$('#search').click(function(){
		//alert('a')
		if(ss){
			$(this).parents('.header').next('.search-box').fadeIn(800);	
			$(this).addClass('del');	//加个class名字换个图片
			$('.bg').fadeIn(800);	
		}else{
			$(this).parents('.header').next('.search-box').fadeOut(800);
			$(this).removeClass('del')
			$('.bg').fadeOut(800);
		}
		ss = !ss;	
	})

	//页脚 显示 隐藏
	var ss = true;
	$('.map').click(function(){
		//alert('a')
        $('.footer-tk').fadeIn(800);	
		//$(this).parents('.index-footer').parents('.footer').prev('.footer-tk').fadeIn(800);	
		//$('.bg').fadeIn(800);	
	})
	$('.close').click(function(){
		$('.footer-tk').fadeOut(800);
		//$('.bg').fadeOut(800);
	})

	//FAQ
	$('.acd-list h2').click(function(){
		$(this).parent('.acd-list').css({'height':'auto'});	
	});
	$('.up').click(function(){
		$(this).parent('.acd-content').parent('.acd-list').css({'height':'52px'});
	})

 	// 新闻中心切换
 	/*$('.new-tab li').click(function(){
	    $('.new').hide();
		$('.new').eq($(this).index()).show();		
		$('.new-tab li').removeClass('cur');
		$('.new-tab li').eq($(this).index()).addClass('cur');
	})*/


	$('.download-a a:nth-child(4n)').css({'margin-right':'0'});

	//头部弹框登录
	$('.header-user .name').click(function(){
		alert("asdf");
		$('.denglu').fadeIn(800);	
		$('.tan-bg').fadeIn(800);	
		//$(".box").toggle(); 
		$('body').one('click',function(){
	        $('.denglu').fadeOut(800);
	        $('.tan-bg').fadeOut(800);
	        $('.add-tan').fadeOut(800);
		})
		 return false;
	})
	$('.denglu,.add-tan').click(function(){
        return false;
    });
    $('b.zhuce').click(function(){
    	$('.denglu').fadeOut(800);
    	$('.add-tan').fadeIn(800);
    })
    $('b.lidenglu').click(function(){
    	$('.denglu').fadeIn(800);
    	$('.add-tan').fadeOut(800);
    })

    //商品单页 规格
    $('.norms-div .norms').click(function(){
		$('.norms-div .norms').removeClass('cur');
		$('.norms-div .norms').eq($(this).index()).addClass('cur');
	})

	// 购物车 操作 删除
	$('.del').click(function(){
	    $(this).parents('.cart-table tr').remove();
    });

    // 订单确认 收货人
    $('.more').click(function(){
		$(this).prev('.address-ul').css({'height':'auto'});	
	});
	$('.up').click(function(){
		$(this).parent('.acd-content').parent('.acd-list').css({'height':'52px'});
	})
	$('.del').click(function(){
	    $(this).parents('.address-ul li').remove();
    });
    // 订单弹框新加地址 下拉
    $(".tablebox .tablebox1").click(function(){
		$(this).next().show();
		//alert($(this).next().parent().html());
	});
	$(".tablebox2 li").click(function(){
		var value=$(this).html();
		// $(this).find('.tablebox1').html(value);
		$(this).parent().parent().find(".tablebox1").html(value)
		// alert()
		$(".tablebox1").next().hide();
	});
	$(document).on('click', function(e){
		if(e.target.parentNode.id != 'menu'){
			$(".tablebox1").next().hide();
		}
	});
	//订单管理 新加地址 弹框
	$('.add-address').click(function(){
		$('.add-address-tan').fadeIn(800);	
		$('.tan-bg').fadeIn(800);	
		//$(".box").toggle(); 
		$('body').one('click',function(){
	        $('.add-address-tan').fadeOut(800);
	        $('.tan-bg').fadeOut(800);
		})
		 return false;
	})
	$('.add-address-tan').click(function(){
        return false;
    });

    // 个人中心 评价弹框
    $('em.pj').click(function(){
		$('.pj-tan').fadeIn(800);	
		$('.tan-bg').fadeIn(800);	
		//$(".box").toggle(); 
		$('body').one('click',function(){
	        $('.pj-tan').fadeOut(800);
	        $('.tan-bg').fadeOut(800);
		})
		 return false;
	})
	$('.pj-tan').click(function(){
        return false;
    });
    //个人中心 订单 删除
    $('.del').click(function(){
	    $(this).parents('.indent_message li').remove();
    });
})


// 购物车 加减
function jishuan(num){
    var nums = parseInt($(".txtnum").val());
    if(parseInt(num)+nums<1){
       $(".txtnum").val(1);
    }else{
       $(".txtnum").val(parseInt(num)+nums);
    }
}

// 商品单页 购物车定位头部
var searchToggle={
	tab:function(){		
		$(window).scroll(function(){
			if($(window).scrollTop()>100){
				$(".width-100").css({position:'fixed'})
                $(".width-100").css({"top":"0"});
			}else{
				$(".width-100").css({position:'absolute'})
                $(".width-100").css({"top":"100px"});
			}
		})
	}	
}
searchToggle.tab();

// 商品单页 相关商品
jQuery(function(jq){
    var rr = jq('.area');
    var conr = rr.find('div.con'),
        conr0 = conr[0],
        btnWr = rr.find('div.btns'),
        btnPr = btnWr.find('a.up'),
        btnNr = btnWr.find('a.down');
    
    var lisr = conr.find('.left');

    var pnumr = 4, numr = lisr.length;
    if(numr <= pnumr)return;
    
    var owr = lisr[1].offsetLeft - lisr[0].offsetLeft, 
        idxArear = [0, numr - pnumr],
        idxr = 0;
    
    function updateNum(n){
        if (n > idxArear[1] || n < idxArear[0]) {return;}
        
        btnPr[((n == 0)?'add':'remove') + 'Class']('uN');
        btnNr[((n == idxArear[1])?'add':'remove') + 'Class']('dN');
        
        idxr = n;
        conr.stop().animate({left: -n * owr},300);
    }
    
    btnPr.click(function(){
        updateNum(idxr - 1);
        return false;
    });
    btnNr.click(function(){
        updateNum(idxr + 1);
        return false;
    });
});


// 工作招聘 折叠
$(document).on('click','.add-us-box h4',function(){
   if(!$(this).attr('isclick')){
		$('.add-us-box').find('.fadeInUp').slideUp() ;
		//$(this).addClass('active').find('em').addClass('btn_up_up').end() ;
		$(this).attr('isclick','yes');
		$(this).siblings('.fadeInUp').slideDown();
	}else{
		$(this).siblings('.fadeInUp').slideUp() ;
		$(this).removeAttr('isclick');	
	}
});

// 登录 密码
$(document).ready(function(){
    $("input.mima").focus(function(){
      $(this).siblings('.txt-mima').css("display","none");
    });
    $("input.mima").blur(function(){
      $(this).siblings('.txt-mima').css("display","none");
    });
})  