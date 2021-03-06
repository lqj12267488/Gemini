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
                                专业名称：
                            </div>
                            <div class="col-md-2">
                                <input id="developmentteachingnumSel">
                            </div>
                            <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                            <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>

                        </div>


                    </div>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
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
    $(document).ready(function () {


        search();
    })

    function search() {
        var groupNameSel = $("#developmentteachingnumSel").val();
        if (groupNameSel != ""){
            groupNameSel = '%' + groupNameSel + '%';
        }
        $("#table").DataTable({
             "processing": true,
             "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/cooperate/getCooperateList',
                "data": {
                    groupNameSel:groupNameSel
                }
            },
            "destroy": true,
            "columns": [
                 {"data": "id", "title": "主键id", "visible": false},
                 {"data": "mojorName", "title": "专业名称"},
                 {"data": "developmentcoursenum", "title": "共同开发课程数（门）"},
                 {"data": "developmentteachingnum", "title": "共同开发教材数（种）"},
                 {"data": "parttimeteachernum", "title": "支持学校兼职教师数（人）"},
                 {"data": "traineenum", "title": "接受顶岗实习学生数（人）"},
                 {"data": "employmentnumber", "title": "接受毕业生就业数（人）"},
                 {"data": "apprenticeship", "title": "是否合作开展学徒制专业"},
                 {"data": "centerprisenum", "title": "产学合作企业总数(个)"},
                 {"data": "culturenum", "title": "订单培养总数（人）"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            paging: true,
            language: language
        });
    }

    function searchClear() {
        $(".form-row div input,.form-row div select").val("");
        search();
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/cooperate/toCooperateAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/cooperate/toCooperateEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>/cooperate/delCooperate?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
    }
</script>