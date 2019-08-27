<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <input id="deptId" name="deptId" type="hidden" value="${deptId}">
    <input id="id" name="id" type="hidden" value="${id}">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${trainingProjectName} > 上报参培老师</span>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                参培教师：
                            </div>
                            <div class="col-md-2">
                                <input id="teacher"/>
                            </div>

                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="reportTeacher()">上报参培教师
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="groupReport" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var table;

    $(document).ready(function () {
        //参培教师
        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#teacher").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacher").val(ui.item.label);
                    $("#teacher").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        table = $("#groupReport").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/training/group/getReportMemberList?id=${id}',
            },
            "destroy": true,
            "columns": [
                {"data": "memberId", "visible": false},
                {"data": "deptId", "visible": false},
                {"data": "personId", "visible": false},
                {"width": "10%","data": "trainingShow", "title": "培训名称"},
                {"width": "10%","data": "deptShow", "title": "参培部门"},
                {"width": "10%","data": "personShow", "title": "参培教师"},
                {"width": "10%", "title": "操作", "render": function () {return "<a id='delReportTeacher' class='icon-trash' title='删除'></a>";}}
            ],
            'order' : [[1,'desc']],
            "dom": 'rtlip',
            language: language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var memberId = data.memberId;
            var id = $("#id").val();
            if (this.id == "delReportTeacher") {
                //if (confirm("请确认是否要删除本条教师记录?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "参培教师："+data.personShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/training/group/delReportTeacher?memberId="+memberId+"&id="+id, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg);
                        $('#groupReport').DataTable().ajax.reload();

                    })
                })
            }

        });

    })

    function reportTeacher() {
        var id = $("#id").val();
        var deptId = $("#deptId").val();
        $.get("<%=request.getContextPath()%>/training/group/checkReportTeacher?id="+id, function (data) {
            if(data.status==1){
                swal({
                    title: msg.msg,
                    type: "error"
                });
                //alert(data.msg);
            }else{
                $("#dialog").load("<%=request.getContextPath()%>/training/group/toReportTeacher?id="+id+"&deptId="+deptId);
                $("#dialog").modal("show");
            }
        })

    }

    function search() {
        var teacher = $("#teacher").val();
        if (teacher == "") {

        } else{
            table.ajax.url("<%=request.getContextPath()%>/training/group/getReportMemberList?personId="+teacher).load();
        }
    }

    function searchclear() {
        $("#teacher").val("");
        table.ajax.url("<%=request.getContextPath()%>/training/group/getReportMemberList?id=${id}").load();
    }


    function back() {
        $("#right").load("<%=request.getContextPath()%>/training/group/report");
    }
</script>
