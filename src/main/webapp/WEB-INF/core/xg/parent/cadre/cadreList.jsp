<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <header class="mui-bar mui-bar-nav">
                        <h5 class="mui-title"> 班级信息</h5>
                    </header>
                    <br>
                    <ul class="nav nav-tabs nav-justified">
                        <c:forEach items="${className}" var="classObj">
                            <li><a href="#li_${classObj.id}" id="menu_${classObj.id}" data-toggle="tab">${classObj.text}班级基本信息</a></li>
                        </c:forEach>
                    </ul>
                    <div class="content tab-content">
                        <c:forEach items="${className}" var="classObj">
                            <div class="tab-pane" id="li_${classObj.id}">
                                <div id="cont_${classObj.id}"></div>
                                <br/>
                                <h5 class="mui-title">${classObj.text}班级 班干部列表</h5>
                                <div class="form-row " style="overflow-y:auto;">
                                    <table id="grid_${classObj.id}" cellpadding="0" cellspacing="0"
                                           width="100%" style="max-height: 50%;min-height: 10%;"
                                           class="table table-bordered table-striped sortable_default">
                                    </table>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="teacherId" hidden value="${teacherId}">
</div>
<script>

    $(document).ready(function () {
        document.getElementById("menu_${classCheck}").click();
        var classList = JSON.parse('${classList}');
        $.each(classList, function (index, content) {
            $.get("<%=request.getContextPath()%>/core/parent/getClassCadreList",{classId: content.id},
                function (data) {
                    var count = "班级人数<br/><br/>";
                    $.each(data.sexSel, function (i, sex) {
                        count = count +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ sex.id+"&nbsp;:&nbsp;"+sex.text + "人&nbsp;" ;
                    })
                    $("#cont_"+content.id).html(count);
                    var grid= $("#grid_"+content.id).DataTable({
                        "data":data.data,
                        "destroy": true,
                        "columns": [
                            {"data":"className","title":"班级"},
                            {"data":"studentName","title":"学生"},
                            {"data":"cadrecoadShow","title":"职位"}
                        ],
                        "dom": 'rtlip',
                        language: language
                    });
                });
        })
    })

</script>
