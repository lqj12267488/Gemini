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


</style>
<div class="row">
    <div class="col-md-2">

        <div class="block block-drop-shadow">

            <div class="content controls" id="style-4" style="overflow-y:auto;height: 89%">

            </div>
        </div>
    </div>
    <div class="col-md-10">
        <div id="right" style="height: 90%"></div>
    </div>
</div>
<script>
    $(document).ready(function () {
        var menuList = "";
        var datalist =${menusList};
        $.each(datalist, function (index, content) {
            if (content.menuList == null || content.menuList == "") {
                menuList = menuList + '<li>' +
                    '<a href="#" id="m_' + content.resourceid + '" onclick=\"changeRight(\'' + content.resourceid + '\',\'' + content.resourceurl + '\')\">' +
                    '<span class="icon-align-justify"></span>' + content.resourcename +
                    '</a>' +
                    '</li>';
            } else {
                var menuChild = content.menuList;
                var menuChildhtm = "";
                $.each(menuChild, function (index1, content1) {
                    menuChildhtm = menuChildhtm + '<li><div >' +
                        '<a href="#" id="m_' + content1.resourceid + '" onclick=\"changeRight(\'' + content1.resourceid + '\',\'' + content1.resourceurl + '\')\">' +
                        content1.resourcename +
                        '</a></div>' +
                        '</li>';
                })
                menuList = menuList + '<li>' +
                    '<a href="#" id="Menu_' + content.resourceid + '" onclick=\"showMenuChildList(\'' + content.resourceid + '\')\">' +
                    '<span class="icon-align-justify"></span>' + content.resourcename +
                    '</a>' +
                    '<ul id="childList_' + content.resourceid + '">' + menuChildhtm + '</ul>' +
                    '</li>';

            }
        })
        $("#style-4").html('<ul class="page-navigation">' + menuList + '</ul>');
    });

    var checkMenuId = "";

    function showMenuChildList(id) {
        $("#childList_" + checkMenuId).css('display', 'none');
        if (id == checkMenuId) {
            checkMenuId = "";
        } else {
            $("#childList_" + id).css('display', 'block');
            checkMenuId = id;
        }
    }

    var checkMenu = "";

    function changeRight(id, url) {
        if (checkMenu != "") {
            $("#m_" + checkMenu).css('background', '');

        }
        //  :
        $("#m_" + id).css('background', 'rgba(0,0,0,0.1)');

        checkMenu = id;
        if (url != '' && url != null && url != 'null')
            $("#right").load('<%=request.getContextPath()%>' + url, {id: id});
        else
            $("#right").load("<%=request.getContextPath()%>/building");
    }
</script>