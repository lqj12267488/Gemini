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
                                通信地址：
                            </div>
                            <div class="col-md-2">
                                <input id="mailingAddressSel">
                            </div>
                            <div class="col-md-1 tar">
                                邮政编码：
                            </div>
                            <div class="col-md-2">
                                <input id="postalCodeSel">
                            </div>
                            <div class="col-md-1 tar">
                                学校网址：
                            </div>
                            <div class="col-md-2">
                                <input id="schoolWebsiteSel">
                            </div>
                            <div class="col-md-1 tar">
                                法人区号－电话号码：
                            </div>
                            <div class="col-md-2">
                                <input id="areaNumberSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                法人区号－传真号：
                            </div>
                            <div class="col-md-2">
                                <input id="areaFaxSel">
                            </div>
                            <div class="col-md-1 tar">
                                法人电子邮箱：
                            </div>
                            <div class="col-md-2">
                                <input id="mailBoxSel">
                            </div>
                            <div class="col-md-1 tar">
                                联系人区号－电话号码：
                            </div>
                            <div class="col-md-2">
                                <input id="contactsAreaNumberSel">
                            </div>
                            <div class="col-md-1 tar">
                                联系人区号－传真号：
                            </div>
                            <div class="col-md-2">
                                <input id="contactsAreaFaxSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                联系人电子邮箱：
                            </div>
                            <div class="col-md-2">
                                <input id="contactsMailBoxSel">
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
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
        $("#table").DataTable({
             "processing": true,
             "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/contactinformation/getContactInformationList',
                "data": {
                    mailingAddress: $("#mailingAddressSel").val(),
                    postalCode: $("#postalCodeSel").val(),
                    schoolWebsite: $("#schoolWebsiteSel").val(),
                    areaNumber: $("#areaNumberSel").val(),
                    areaFax: $("#areaFaxSel").val(),
                    mailBox: $("#mailBoxSel").val(),
                    contactsAreaNumber: $("#contactsAreaNumberSel").val(),
                    contactsAreaFax: $("#contactsAreaFaxSel").val(),
                    contactsMailBox: $("#contactsMailBoxSel").val(),
                }
            },
            "destroy": true,
            "columns": [
                 {"data": "id", "title": "主键id", "visible": false},
                 {"data": "mailingAddress", "title": "通信地址"},
                 {"data": "postalCode", "title": "邮政编码"},
                 {"data": "schoolWebsite", "title": "学校网址"},
                 {"data": "areaNumber", "title": "法人区号－电话号码"},
                 {"data": "areaFax", "title": "法人区号－传真号"},
                 {"data": "mailBox", "title": "法人电子邮箱"},
                 {"data": "contactsAreaNumber", "title": "联系人区号－电话号码"},
                 {"data": "contactsAreaFax", "title": "联系人区号－传真号"},
                 {"data": "contactsMailBox", "title": "联系人电子邮箱"},
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
        $("#dialog").load("<%=request.getContextPath()%>/contactinformation/toContactInformationAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/contactinformation/toContactInformationEdit?id=" + id)
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
            $.get("<%=request.getContextPath()%>/contactinformation/delContactInformation?id=" + id, function (msg) {
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