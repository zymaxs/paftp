$(document).ready(function(){
	$(".top_navi a").each(function(){ 
        $this = $(this);
        if(window.location.href.indexOf($this.attr("href")) !== -1){
            $this.addClass("page_select");  
        }  
    });  
});