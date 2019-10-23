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
                                年份：
                            </div>
                            <div class="col-md-2">
                                <select id="yearss"></select>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'yearss');
        });

        search();
    })

    function search() {
        $("#table").DataTable({
             "processing": true,
             "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/institutionalarea/getInstitutionalAreaList',
                "data": {
                    areaCovered: $("#areaCoveredSel").val(),
                    greenLandArea: $("#greenLandAreaSel").val(),
                    buildingArea: $("#buildingAreaSel").val(),
                    schoolPropertyArea: $("#schoolPropertyAreaSel").val(),
                    schoolBuilding: $("#schoolBuildingSel").val(),
                    wrongSchoolProperty: $("#wrongSchoolPropertySel").val(),
                    scientificAuxiliary: $("#scientificAuxiliarySel").val(),
                    classroom: $("#classroomSel").val(),
                    library: $("#librarySel").val(),
                    laboratoriesPlaces: $("#laboratoriesPlacesSel").val(),
                    researchRoom: $("#researchRoomSel").val(),
                    gymnasium: $("#gymnasiumSel").val(),
                    hall: $("#hallSel").val(),
                    administrativeOffice: $("#administrativeOfficeSel").val(),
                    collegeAreaRoom: $("#collegeAreaRoomSel").val(),
                    studentDormitory: $("#studentDormitorySel").val(),
                    studentCanteen: $("#studentCanteenSel").val(),
                    teachingDormitory: $("#teachingDormitorySel").val(),
                    staffCan: $("#staffCanSel").val(),
                    lifeWelfare: $("#lifeWelfareSel").val(),
                    facultyHousing: $("#facultyHousingSel").val(),
                    otherRooms: $("#otherRoomsSel").val(),
                    year:$("#yearss").val(),
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "title": "主键id", "visible": false},
                {"data": "areaCovered", "title": "占地面积"},
                {"data": "buildingArea", "title": "校舍总建筑面积"},
                {"data": "scientificAuxiliary", "title": "教学科研及辅助用房"},
                {"data": "administrativeOffice", "title": "行政办公用房"},
                {"data": "collegeAreaRoom", "title": "生活用房"},
                {"data": "facultyHousing", "title": "教工住宅"},
                {"data": "otherRooms", "title": "其他用房"},
                {"data": "year", "title": "年份"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '")></span>&ensp;&ensp;' +
                                '<span class="icon-eye-open" title="查看" onclick=see("' + row.id + '")></span>&ensp;&ensp;' +
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
        $("#dialog").load("<%=request.getContextPath()%>/institutionalarea/toInstitutionalAreaAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/institutionalarea/toInstitutionalAreaEdit?id=" + id)
        $("#dialog").modal("show")
    }
    function see(id) {
        $("#dialog").load("<%=request.getContextPath()%>/institutionalarea/toInstitutionalAreaEdit?id=" + id+"&flag=on")
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
            $.get("<%=request.getContextPath()%>/institutionalarea/delInstitutionalArea?id=" + id, function (msg) {
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