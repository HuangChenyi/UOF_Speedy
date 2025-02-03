<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LinkedFieldUC.ascx.cs" Inherits="WKF_FormManagement_VersionFieldUserControl_LinkedFieldUC" %>
<%@ Reference Control="~/WKF/FormManagement/VersionFieldUserControl/VersionFieldUC.ascx" %>
<script type="text/javascript">

    function <%=getFuncName%>(method) {
        if (method == "View") {
            return "<%=this.tbx_value.ClientID%>";
        }
        else {
            return "<%=this.rdlMain.ClientID%>";
        }
    }

    Sys.Application.add_load(function () {

        var hfSubSelectedValue = $('#<%=hfSubSelectedValue.ClientID%>').val();
        var hfMainSelectedValue = $('#<%=hfMainSelectedValue.ClientID%>').val();

        if (hfMainSelectedValue !== '' && hfMainSelectedValue !== null && hfSubSelectedValue !== null)
            SetRdlSubItem_<%=VersionField.FieldID %>(hfMainSelectedValue, true);
    });

    function SetRdlSubItem_<%=VersionField.FieldID %>(selectItemValue, isFromInit) {

        var hfMainSelectedValue = $('#<%=hfMainSelectedValue.ClientID%>').val();
        var hfSubSelectedValue = $('#<%=hfSubSelectedValue.ClientID%>').val();

        var rdlMain = $find("<%=rdlMain.ClientID %>")
        var rdlSub = $find("<%=rdlSub.ClientID %>");
 
        var hfJsonNodeItems = $("#<%=hfJsonNodeItems.ClientID %>");
        var WriteMsg = $("#<%=hdwriteMsg.ClientID %>");

        if (hfJsonNodeItems[0] === undefined)
            return;

        var jsonData = JSON.parse(hfJsonNodeItems.val());

        var matchingSubNodes = jsonData
            .filter(function (node) {
                return node.nodeName === selectItemValue;
            })
            .map(function (node) {
                return node.SubNodes;
            })
            .flat();

        if (rdlSub !== null) {

            rdlSub.get_items().clear();

            var isCondition = '<%=IsCondition%>';

            if (isCondition === 'False') {
                var defaultOption = new Telerik.Web.UI.DropDownListItem();
                defaultOption.set_text(WriteMsg.val());
                defaultOption.set_value("###***$$$");
                rdlSub.get_items().add(defaultOption);
            }

            for (var i = 0; i < matchingSubNodes.length; i++) {
                var newItem = new Telerik.Web.UI.DropDownListItem();
                newItem.set_text($telerik.htmlEncode(matchingSubNodes[i].nodeName));
                newItem.set_value(matchingSubNodes[i].nodeName);
                rdlSub.get_items().add(newItem);
            }

            var findItemText = '';

            if (isFromInit)
                findItemText = hfSubSelectedValue;
            else
                findItemText = WriteMsg.val();

            if (isCondition && !isFromInit) //條件設定中+非初始化，不需要"請選擇"項目
                findItemText = rdlSub.get_items()._array[0]._text;

            var item = rdlSub.findItemByText(findItemText);
            if (item !== null) {
                item.select();
            }

            rdlSub.commitChanges();
        }
    }

    function rdlMainOnSelectedChange_<%=VersionField.FieldID %>() {

        var rdlMain = $find("<%=rdlMain.ClientID %>")
        var mainSelectedValue = '';

        if (rdlMain !== null)
            mainSelectedValue = rdlMain._selectedValue;

        SetRdlSubItem_<%=VersionField.FieldID %>(mainSelectedValue, false);

        //切換父欄位的時候，要把子欄位選中的項目給記錄下來(因前端重新塞入子欄位選項後，後端SelectedValue跟Index都會找不到值)
        var rdlSub = $find("<%=rdlSub.ClientID %>")
        var subSelectedValue = rdlSub._selectedValue;

        $('#<%=hfSubSelectedValue.ClientID%>').val(subSelectedValue);
    }

    function rdlSubOnSelectedChange_<%=VersionField.FieldID %>() {

        var rdlSub = $find("<%=rdlSub.ClientID %>");
        var rdlMain = $find("<%=rdlMain.ClientID %>");

        var subSelectedValue = rdlSub._selectedValue;
        var mainSelectValue = rdlMain._selectedValue;

        rdlSub._selectedText = $telerik.htmlDecode(rdlSub._selectedText);

        $('#<%=hfSubSelectedValue.ClientID%>').val(subSelectedValue);
        $('#<%=hfMainSelectedValue.ClientID%>').val(mainSelectValue);
    }

</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 97%" id="tbField" runat="server">
            <tr>
                <td>
                    <asp:LinkButton ID="lnk_Edit" runat="server" CausesValidation="false" OnClick="lnk_Edit_Click" Visible="False" meta:resourcekey="lnk_EditResource1">[修改]</asp:LinkButton>
                    <asp:LinkButton ID="lnk_Cannel" runat="server" CausesValidation="false" OnClick="lnk_Cannel_Click" Visible="False" meta:resourcekey="lnk_CannelResource1">[取消]</asp:LinkButton>
                    <asp:LinkButton ID="lnk_Submit" runat="server" CausesValidation="false" OnClick="lnk_Submit_Click" Visible="False" meta:resourcekey="lnk_SubmitResource1">[確定]</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td id="tdInvisible" runat="server">
                    <asp:Label ID="lblInvisible" runat="server" Text="******"></asp:Label>
                </td>
                <td id="tdVisible" runat="server">
                    <telerik:RadDropDownList ID="rdlMain" runat="server" CssClass="DropDownLinked" DropDownWidth="100%"></telerik:RadDropDownList>
                    <telerik:RadDropDownList ID="rdlSub" runat="server" CssClass="DropDownLinked" DropDownWidth="100%"></telerik:RadDropDownList>
                    <asp:Label ID="lblDropDown" runat="server" Visible="False" meta:resourcekey="lblDropDownResource1" Style="-webkit-text-size-adjust: 100%"></asp:Label>
                    <asp:HyperLink ID="hyperlinkFocus1" NavigateUrl="#" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divWS" runat="server">
                        <asp:Button ID="Button1" runat="server" meta:resourcekey="Button1Resource1" OnClick="Button1_Click" Text="取得值" Visible="False" CausesValidation="False" />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" Display="Dynamic" ErrorMessage="請選擇項目"
                            meta:resourcekey="CustomValidator1Resource1" ForeColor="Red" EnableTheming="true">
                        </asp:CustomValidator>
                        <asp:CustomValidator ID="CustomValidatorSend" runat="server" Display="Dynamic" ErrorMessage="請選擇項目"
                            meta:resourcekey="CustomValidator1Resource1" ForeColor="Red" EnableTheming="true">
                        </asp:CustomValidator>
                    </div>
                    <asp:Label ID="lblHasNoAuthority" runat="server" ForeColor="Red" Text="無填寫權限" Visible="False" meta:resourcekey="lblHasNoAuthorityResource1"></asp:Label>
                    <asp:Label ID="lblFiller" CssClass="FillerVisible" runat="server" meta:resourcekey="lblFillerResource1"></asp:Label>
                    <asp:Label ID="lblModifier" runat="server" Visible="False" meta:resourcekey="lblModifierResource1"></asp:Label>
                    <asp:Label ID="lblMsgSigner" runat="server" Text="填寫者" Visible="False" meta:resourcekey="lblMsgSignerResource1"></asp:Label>
                    <asp:Label ID="lblMsgEditor" runat="server" Text="修改者" Visible="False" meta:resourcekey="lblMsgEditorResource1"></asp:Label>
                    <asp:Label ID="lblAuthorityMsg" runat="server" Text="具填寫權限人員" Visible="False" meta:resourcekey="lblAuthorityMsgResource1"></asp:Label>
                    <asp:Label ID="lblField" runat="server" Text="外部資料訊息:" Visible="False" meta:resourcekey="lblFieldResource1" Font-Bold="False" ForeColor="Red"></asp:Label>
                    <asp:Label ID="lblShowWSMsg" meta:resourcekey="lblShowWSMsgResource1" runat="server" Font-Bold="False" ForeColor="Red" Visible="False"></asp:Label>
                    <asp:Label ID="lblWebServiceMsg" runat="server" Text="資料格式錯誤" meta:resourcekey="lblWebServiceMsgResource1" Visible="False" Font-Bold="False" ForeColor="Red"></asp:Label>
                    <asp:Label ID="lblotherMSG" runat="server" ForeColor="Red" Text="呼叫外部資料時發生錯誤" Visible="False" meta:resourcekey="lblotherMSGResource1"></asp:Label>
                    <asp:Label ID="lbl_WriteMsg" runat="server" Text="─請選擇─" Visible="False" meta:resourcekey="lbl_WriteMsgResource1"></asp:Label>

                    <asp:HiddenField ID="hfSubSelectedValue" runat="server" />
                    <asp:HiddenField ID="hfMainSelectedValue" runat="server" />
                    <asp:HiddenField ID="hfJsonNodeItems" runat="server" />
                    <asp:HiddenField ID="tbx_value" runat="server" />
                    <asp:HiddenField ID="tbx_Text" runat="server" />
                    <asp:HiddenField ID="hdwriteMsg" runat="server" Value="─請選擇─" meta:resourcekey="hdwriteMsgResource1" />
                </td>
            </tr>
        </table>       
    </ContentTemplate>
</asp:UpdatePanel>
