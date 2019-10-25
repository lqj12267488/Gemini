<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
            <div class="block block-drop-shadow content block-fill-white">
                   <div class="form-row">
                        <div class="col-md-1 tar">
                            名称：
                        </div>
                        <div class="col-md-2">
                            <input id="givennameSel">
                        </div>

                       <div class="col-md-1 tar">
                           姓名
                       </div>
                       <div class="col-md-2">
                           <input id="perIdSel"/>
                       </div>
                       <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                       <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                  </div>

            </div>

                <div class="block block-drop-shadow content">
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
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#perIdSel").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#perIdSel").val(ui.item.label);
                    $("#perIdSel").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        search();
    })

    function search() {
        var groupNameSel = $("#givennameSel").val();
        if (groupNameSel != ""){
            groupNameSel = '%' + groupNameSel + '%';
        }

        var headT = $("#perIdSel").attr("keycode");
        var person = "";
        if (null == headT){
        } else {
            var personList = headT.split(",");
            person = personList[1];
            var dept = personList[0];
        }
        $("#table").DataTable({
             "processing": true,
             "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/Staff/getStaffList?type=2',
                "data": {
                    groupNameSel:groupNameSel,
                    personid:person

                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "title": "主键","visible": false},
                 {"data": "personid", "title": "教工号","visible": false},
                 {"data": "name", "title": "姓名"},

                 {"data": "gradeShow", "title": "等级"},
                 {"data": "givenname", "title": "名称"},
                 {"data": "issuer", "title": "发证单位"},
                 {"data": "getdate", "title": "获取日期"},
                 /*{"data": "teachingmanagement", "title": "从事教学管理年限"},*/
                 {"data": "studentmanagement", "title": "从事学生管理年限"},
                 {"data": "politicalcounselor", "title": "是否专职政治辅导员"},
                 {"data": "psychologicalconsultant", "title": "是否专职心理咨询师"},
                 {"data": "postfunction", "title": "岗位职能"},
                 {"data": "workingyears", "title": "本岗位工作年限"},
                 /*{"data": "employmentoffice", "title": "从事招生就业工作年限"},
                 {"data": "expertise", "title": "专业领域"},
                 {"data": "workinghours", "title": "周工作小时数"},*/
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
        $("#perIdSel").removeAttr("keycode");
        search();
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/Staff/toStaffStudentAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/Staff/toStaffStudentEdit?id=" + id)
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
            $.get("<%=request.getContextPath()%>/Staff/delStaff?id=" + id, function (msg) {
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