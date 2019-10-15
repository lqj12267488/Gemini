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
                            课题名称：
                        </div>
                        <div class="col-md-2">
                            <input id="subjectnameSel">
                        </div>

      <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
      <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>

                  </div>

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


        search();
    })

    function search() {
        var groupNameSel = $("#subjectnameSel").val();
        if (groupNameSel != ""){
            groupNameSel = '%' + groupNameSel + '%';
        }
        $("#table").DataTable({
             "processing": true,
             "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/TeacherSchool/getTeacherSchoolList',
                "data": {
                    groupNameSel:groupNameSel,
                    type: "2",
                }
            },
            "destroy": true,
            "columns": [
                 {"data": "id", "title": "主键id", "visible": false},
                 {"data": "personid", "title": "教职工id","visible": false},
                 {"data": "name", "title": "教职工"},
                 {"data": "whetherhost", "title": "是否主持"},
                 {"data": "inventnumber", "title": "技术专利(发明)编号"},
                 {"data": "topicnature", "title": "课题性质"},
                 {"data": "subjectclassification", "title": "课题分类"},
                 {"data": "subjectname", "title": "课题名称"},
                 {"data": "horizontaltopic", "title": "是否横向课题"},
                 {"data": "subjectgrade", "title": "课题级别"},
                 {"data": "projectdate", "title": "立项日期"},
                 {"data": "sourceoffunding", "title": "经费来源"},
                 {"data": "money", "title": "到款金额 "},
                 {"data": "completororder", "title": "完成人顺序 "},
                 {"data": "classification", "title": "著作与论文分类 "},
                 {"data": "authororder", "title": "作者顺序 "},

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
        $("#dialog").load("<%=request.getContextPath()%>/TeacherSchool/toConcurrentSchoolAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/TeacherSchool/toConcurrentSchoolEdit?id=" + id)
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
            $.get("<%=request.getContextPath()%>/TeacherSchool/delTeacherSchool?id=" + id, function (msg) {
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