<%--教科研成果统计
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/2
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">

                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="s_personId" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                所属部门：
                            </div>
                            <div class="col-md-2">
                                <input id="s_deptId" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                成果类型：
                            </div>
                            <div class="col-md-2">
                                <select id="s_resultType" class="js-example-basic-single" ></select>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchClear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="countGrid" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var countTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/teacherResult/getPerson", function (data) {
            $("#s_personId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#s_personId").val(ui.item.label);
                    $("#s_personId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        autoComplateOption("s_deptId", "<%=request.getContextPath()%>/common/getDeptByName");

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=CGLX", function (data) {
            addOption(data, 's_resultType','${patent.typicalFlag}');
        });
        search();

        countTable.on('click', 'tr a', function () {
            var data = countTable.row($(this).parent()).data();
            var id = data.id;
            var resultType=data.resultType;
            //查看
            if (this.id == "look") {
                if (resultType == "项目（课题）") {
                    $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/project",{id:id,flag:"on"});
                    $("#dialog").modal("show");
                }else if (resultType == "国家标准或行业标准") {
                    $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/standard",{id:id,flag:"on"});
                    $("#dialog").modal("show");
                }else if (resultType == "国家医药证书") {
                    $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/medicine",{id:id,flag:"on"});
                    $("#dialog").modal("show");
                }else if (resultType == "论文") {
                    $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/paper",{id:id,flag:"on"});
                    $("#dialog").modal("show");
                }else if (resultType == "文艺作品") {
                    $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/art",{id:id,flag:"on"});
                    $("#dialog").modal("show");
                }else if (resultType == "指导学生参加竞赛获奖") {
                    $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/guide",{id:id,flag:"on"});
                    $("#dialog").modal("show");
                }else if (resultType == "著作") {
                    $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/writing",{id:id,flag:"on"});
                    $("#dialog").modal("show");
                }else if (resultType == "专利或软件著作权") {
                    $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/patent",{id:id,flag:"on"});
                    $("#dialog").modal("show");
                }else{
                    $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/report",{id:id,flag:"on"});
                    $("#dialog").modal("show");
                }
            }
        });
    })
    //清空
    function searchClear() {
        $("#s_personId").val("");
        $("#s_personId").attr("keycode","");
        $("#s_deptId").val("");
        $("#s_deptId").attr("keycode","");
        $("#s_resultType").val("");
        search();
    }
    //列表查询
    function search(){
        var personId = $("#s_personId").attr("keycode");
        var deptId = $("#s_deptId").val();
        var resultType = $("#s_resultType").val();
        countTable = $("#countGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teacherResult/teachingResultCount',
                "data": {
                    personId: personId,
                    deptId: deptId,
                    resultType: resultType
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "6%", "data": "personId", "title": "姓名"},
                {"width": "12%", "data": "deptId", "title": "所属部门"},
                {"width": "12%", "data": "resultType", "title": "成果类型"},
                {"width": "12%", "data": "creator", "title": "创建人"},
                {"width": "12%", "data": "createDept", "title": "创建部门"},
                {"width": "12%", "data": "createDate", "title": "创建时间"},
//                {
//                    "width": "7%",
//                    "title": "附件",
//                    "render": function () {
//                        return "<button style='text-align:center' type='button' id='upload' onclick='uploadFiles()'>上传附件</button>";
//                    }
//                },
                {"width": "8%","title": "操作","render": function () {return "<a id='look' class='icon-search'></a>";}}
            ],
            'order' : [6,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function uploadFiles() {
        alert(00);
    }
</script>
