<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="mainInclude.jsp"/>
<style>

    .echarts_li {
        width: 49%;
        height: 350px;
        float: left;
        -webkit-transform: scale(1);
        transform: scale(1);
    }

    .echarts_li_bottom {
        width: 99%;
        height: 350px;
        float: left;
    }

    #style-4::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
        background-color: #474D52;
    }

    #style-4::-webkit-scrollbar {
        width: 5px;
        background-color: #474D52;
    }

    #style-4::-webkit-scrollbar-thumb {
        background-color: #ffffff;
        border: 1px solid #474D52;
    }

    li.a {
        font-size: 14px;
    }

    .page-navigation li a i[class^='icon-'] {
        position: absolute;
        left: 10px;
        top: 10px;
        font-size: 12px;
    }

    .menu-item {
        width: 100%;
    }

    .page-navigation > li > ul > li > a {
        padding-left: 50px;
    }

    .page-navigation > li > ul > li > a i[class^='icon-'] {
        padding-left: 20px;
    }

    .page-navigation > li > ul > li > ul > li > a {
        padding-left: 60px;
    }

    .menu-content li a {
        padding-left: 50px;
    }

</style>
<div class="row">
    <div class="col-md-2">
        <div class="block block-drop-shadow">
            <div class="content controls" id="style-4" style="overflow-y:auto;height: 89%">
                <ul class="page-navigation">
                    <jsp:include page="sideMenu.jsp"/>
                </ul>
            </div>
        </div>
    </div>
    <div class="col-md-10">
        <div id="right" style="height: 90%"></div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $(".menu-content").bind("click", function () {
            var id = $(this).attr("id");
            if ($("ul[parent='" + id + "']").css("display") == "block") {
                $("ul[parent='" + id + "']").css("display", "none");
            } else {
                $("ul[parent='" + id + "']").css("display", "block");
            }
            $(this).parent().parent().find("ul[parent!='" + id + "']").css("display", "none");
        });
        $(".menu").bind("click", function () {
            var url=  $(this).attr("url");
            if (url == null || url == undefined || url == "")
            {
                $("#right").load("/building");
            }
            else {
                $("#right").load(url);
            }

            if ($(this).parent().parent().hasClass("page-navigation")) {
                $(".page-navigation ul").css("display", "none");
            }
        })
    });
</script>
