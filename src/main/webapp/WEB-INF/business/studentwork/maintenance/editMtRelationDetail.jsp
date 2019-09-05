<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/3
  Time: 8:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>公物类别：
                    </div>
                    <div class="col-md-9">
                        <select id="mtNameEdit" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>物品名称：
                    </div>
                    <div class="col-md-9">
                        <input id="goodNameEdit" value="${mrDetailEdit.goodName}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>单位：
                    </div>
                    <div class="col-md-9">
                        <input id="goodUnitEdit" value="${mrDetailEdit.goodUnit}"  />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>单价：
                    </div>
                    <div class="col-md-9">
                        <input id="unitPriceEdit"  value="${mrDetailEdit.unitPrice}" onchange="priceChange()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>数量：
                    </div>
                    <div class="col-md-9">
                        <input id="goodNumEdit"  value="${mrDetailEdit.goodNum}" onchange="numChange()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>金额：
                    </div>
                    <div class="col-md-9">
                        <input id="goodPriceEdit"   value="${mrDetailEdit.goodPrice}" readonly />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        物品使用情况：
                    </div>
                    <div class="col-md-9">
                        <input id="goodCaseEdit"  value="${mrDetailEdit.goodCase}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注：
                    </div>
                    <div class="col-md-9">
                        <input id="goodRemarkEdit"  value="${mrDetailEdit.goodRemark}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " MT_ID ",
                text: " MT_NAME",
                tableName: " T_XG_MAINTENANCE_TYPE ",
                where:" where  valid_flag = '1'"
            },
            function (data) {
                addOption(data, "mtNameEdit",'${mrDetailEdit.mtId}');
            });
    })

    function save() {
        $.post("<%=request.getContextPath()%>/mtRelation/saveMRDetail", {
            id:"${mrDetailEdit.id}",
            relId:"${mrDetailEdit.relId}",
            mtId: $("#mtNameEdit").val(),
            goodName: $("#goodNameEdit").val(),
            goodNum:$("#goodNumEdit").val(),
            goodUnit:$("#goodUnitEdit").val(),
            unitPrice:$("#unitPriceEdit").val(),
            goodCase:$("#goodCaseEdit").val(),
            goodRemark:$("#goodRemarkEdit").val()
        },function (msg) {
            swal({title: msg.msg,type: "success"});
            $("#dialog").modal('hide');
            $('#mRDetailGrid').DataTable().ajax.reload();
        })
    }
    
    function priceChange() {
        if ( typeof (parseInt($("#goodNumEdit").val()))=="number" && typeof (parseInt($("#unitPriceEdit").val()))=="number" ){
            if ($("#goodNumEdit").val()!=""&&$("#unitPriceEdit").val()!="") {
                var price = parseInt($("#goodNumEdit").val())* parseInt($("#unitPriceEdit").val());
                $("#goodPriceEdit").val(price);
            }
        }
        
    }
    function numChange() {
        if ( typeof (parseInt($("#goodNumEdit").val()))=="number" && typeof (parseInt($("#unitPriceEdit").val()))=="number"){
            if ($("#goodNumEdit").val()!=""&&$("#unitPriceEdit").val()!="") {
                var price = $("#goodNumEdit").val() * $("#unitPriceEdit").val();
                $("#goodPriceEdit").val(price);
            }
        }
    }
</script>
