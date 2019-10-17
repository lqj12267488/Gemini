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
                                占地面积：
                            </div>
                            <div class="col-md-2">
                                <input id="areaCoveredSel">
                            </div>
                            <div class="col-md-1 tar">
                                绿化用地面积：
                            </div>
                            <div class="col-md-2">
                                <input id="greenLandAreaSel">
                            </div>
                            <div class="col-md-1 tar">
                                校舍总建筑面积：
                            </div>
                            <div class="col-md-2">
                                <input id="buildingAreaSel">
                            </div>
                            <div class="col-md-1 tar">
                                学校产权校舍建筑面积：
                            </div>
                            <div class="col-md-2">
                                <input id="schoolPropertyAreaSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                当年新增校舍：
                            </div>
                            <div class="col-md-2">
                                <input id="schoolBuildingSel">
                            </div>
                            <div class="col-md-1 tar">
                                非学校产权校舍建筑面积：
                            </div>
                            <div class="col-md-2">
                                <input id="wrongSchoolPropertySel">
                            </div>
                            <div class="col-md-1 tar">
                                教学科研及辅助用房：
                            </div>
                            <div class="col-md-2">
                                <input id="scientificAuxiliarySel">
                            </div>
                            <div class="col-md-1 tar">
                                教室：
                            </div>
                            <div class="col-md-2">
                                <input id="classroomSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                图书馆：
                            </div>
                            <div class="col-md-2">
                                <input id="librarySel">
                            </div>
                            <div class="col-md-1 tar">
                                实验室、实习场所：
                            </div>
                            <div class="col-md-2">
                                <input id="laboratoriesPlacesSel">
                            </div>
                            <div class="col-md-1 tar">
                                专用科研用房：
                            </div>
                            <div class="col-md-2">
                                <input id="researchRoomSel">
                            </div>
                            <div class="col-md-1 tar">
                                体育馆：
                            </div>
                            <div class="col-md-2">
                                <input id="gymnasiumSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                会堂：
                            </div>
                            <div class="col-md-2">
                                <input id="hallSel">
                            </div>
                            <div class="col-md-1 tar">
                                行政办公用房：
                            </div>
                            <div class="col-md-2">
                                <input id="administrativeOfficeSel">
                            </div>
                            <div class="col-md-1 tar">
                                生活用房：
                            </div>
                            <div class="col-md-2">
                                <input id="collegeAreaRoomSel">
                            </div>
                            <div class="col-md-1 tar">
                                学生宿舍（公寓）：
                            </div>
                            <div class="col-md-2">
                                <input id="studentDormitorySel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学生食堂：
                            </div>
                            <div class="col-md-2">
                                <input id="studentCanteenSel">
                            </div>
                            <div class="col-md-1 tar">
                                教工宿舍（公寓）：
                            </div>
                            <div class="col-md-2">
                                <input id="teachingDormitorySel">
                            </div>
                            <div class="col-md-1 tar">
                                教工食堂：
                            </div>
                            <div class="col-md-2">
                                <input id="staffCanSel">
                            </div>
                            <div class="col-md-1 tar">
                                生活福利及附属用房：
                            </div>
                            <div class="col-md-2">
                                <input id="lifeWelfareSel">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                教工住宅：
                            </div>
                            <div class="col-md-2">
                                <input id="facultyHousingSel">
                            </div>
                            <div class="col-md-1 tar">
                                其他用房：
                            </div>
                            <div class="col-md-2">
                                <input id="otherRoomsSel">
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
                }
            },
            "destroy": true,
            "columns": [
                 {"data": "id", "title": "主键id", "visible": false},
                 {"data": "areaCovered", "title": "占地面积"},
                 {"data": "greenLandArea", "title": "绿化用地面积"},
                 {"data": "buildingArea", "title": "校舍总建筑面积"},
                 {"data": "schoolPropertyArea", "title": "学校产权校舍建筑面积"},
                 {"data": "schoolBuilding", "title": "当年新增校舍"},
                 {"data": "wrongSchoolProperty", "title": "非学校产权校舍建筑面积"},
                 {"data": "scientificAuxiliary", "title": "教学科研及辅助用房"},
                 {"data": "classroom", "title": "教室"},
                 {"data": "library", "title": "图书馆"},
                 {"data": "laboratoriesPlaces", "title": "实验室、实习场所"},
                 {"data": "researchRoom", "title": "专用科研用房"},
                 {"data": "gymnasium", "title": "体育馆"},
                 {"data": "hall", "title": "会堂"},
                 {"data": "administrativeOffice", "title": "行政办公用房"},
                 {"data": "collegeAreaRoom", "title": "生活用房"},
                 {"data": "studentDormitory", "title": "学生宿舍（公寓）"},
                 {"data": "studentCanteen", "title": "学生食堂"},
                 {"data": "teachingDormitory", "title": "教工宿舍（公寓）"},
                 {"data": "staffCan", "title": "教工食堂"},
                 {"data": "lifeWelfare", "title": "生活福利及附属用房"},
                 {"data": "facultyHousing", "title": "教工住宅"},
                 {"data": "otherRooms", "title": "其他用房"},
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
        $("#dialog").load("<%=request.getContextPath()%>/institutionalarea/toInstitutionalAreaAdd")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>/institutionalarea/toInstitutionalAreaEdit?id=" + id)
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