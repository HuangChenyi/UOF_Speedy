<%@ Page Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" Inherits="WKF_ExternalModule_SetupFormCondition" Title="設定表單條件" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" CodeBehind="SetupFormCondition.aspx.cs" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="System.Web.Extensions" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Fast" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script id="SetupFormConditionJS" type="text/javascript">
        //導頁
        function RedirectPage(url) {
            window.location = url;
            return false;
        }

    </script>
    <script type="text/javascript" id="telerikClientEvents1">
        function RadToolBar1_ButtonClicking(sender, args) {
            var value = args.get_item().get_value();

            if (value == "AddConditionBase") {//新增判斷式
                args.set_cancel(true);
                $uof.dialog.open2("~/WKF/FormManagement/ManageFormConditionBase.aspx", args.get_item(), '<%=lblAddConditionBaseBtnValue.Text%>', 1200, 500, openDialogResult, { "formVersionId": $uof.tool.htmlDecode("<%=System.Web.Security.AntiXss.AntiXssEncoder.HtmlEncode(formVersionId, true) %>"), "FormCondition": "Y" });
            }
            else if (value == "AddCondition") {//新增條件
                args.set_cancel(true);
                $uof.dialog.open2("~/WKF/FormManagement/ManageFormCondition.aspx", args.get_item(), '<%=lblAddConditionBtnValue.Text%>', 1000, 500, openDialogResult, { "formVersionId": $uof.tool.htmlDecode("<%=System.Web.Security.AntiXss.AntiXssEncoder.HtmlEncode(formVersionId, true) %>") });
            }
            else if (value == "DeleteCondition") {
                if (confirm('<%=lblConfirmDelete.Text %>') == false)
                    args.set_cancel(true);
            } else if (value == "SortCondition") {
                args.set_cancel(true);
                $uof.dialog.open2("~/WKF/ExternalModule/SortCondition.aspx", args.get_item(), '<%=lblSortConditionBtnValue.Text%>', 0, 0, openDialogResult, { "formVersionId": $uof.tool.htmlDecode("<%=System.Web.Security.AntiXss.AntiXssEncoder.HtmlEncode(formVersionId, true) %>") });
            } else if (value == "Culture") {
                args.set_cancel(true);
                $uof.dialog.open2("~/WKF/FormManagement/MaintainCondAbbreviationCulture.aspx", args.get_item(), '<%=lblCultureBtnValue.Text%>', 0, 0, openDialogResult, { "formVersionId": $uof.tool.htmlDecode("<%=System.Web.Security.AntiXss.AntiXssEncoder.HtmlEncode(formVersionId, true) %>") });
            } else if (value == "ImportCond") {
                args.set_cancel(true);
                $uof.dialog.open2("~/WKF/FormManagement/ImportCond.aspx", args.get_item(), '<%=lblImportCondBtnValue.Text%>', 500, 500, openDialogResult, { "formVersionId": $uof.tool.htmlDecode("<%=System.Web.Security.AntiXss.AntiXssEncoder.HtmlEncode(formVersionId, true) %>") });
            }
        }

        function openDialogResult(returnValue) {
            if (typeof (returnValue) == "undefined") {
                return false;
            }
            return true;
        }
    </script>

    <asp:UpdatePanel id="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
        <contenttemplate>
            <table width="100%">
                <tbody>
                    <tr>
                        <td>

                            <telerik:RadButton ID="ibtnSetupCondition" runat="server" Text="1.設定表單條件&gt;&gt;" CausesValidation="False" AutoPostBack="false"
                                meta:resourcekey="ibtnSetupConditionResource1">
                            </telerik:RadButton>
                            <telerik:RadButton ID="ibtnDesignFlow" runat="server" Text="2.設定表單流程&gt;&gt;" CausesValidation="False" AutoPostBack="false"
                                meta:resourcekey="ibtnDesignFlowResource1">
                            </telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:radtoolbar id="RadToolBar1" runat="server" onbuttonclick="RadToolBar1_ButtonClick" onclientbuttonclicking="RadToolBar1_ButtonClicking" width="100%">
                                <items>
                                    <telerik:radtoolbarbutton runat="server" text="新增判斷式" meta:resourcekey="TBarButtonResource1"
                                        imageurl="~/Common/Images/Icon/icon_m06.gif"
                                        hoveredimageurl="~/Common/Images/Icon/icon_m06.gif"
                                        disabledimageurl="~/Common/Images/Icon/icon_m06.gif"
                                        checkedimageurl="~/Common/Images/Icon/icon_m06.gif"
                                        value="AddConditionBase">
                                    </telerik:radtoolbarbutton>
                                    <telerik:radtoolbarbutton runat="server" isseparator="True" text="Button 1" imageurl="~/App_Themes/DefaultTheme/images/toolbarSp.jpg">
                                    </telerik:radtoolbarbutton>
                                    <telerik:radtoolbarbutton runat="server" text="新增條件" meta:resourcekey="TBarButtonResource2"
                                        imageurl="~/Common/Images/Icon/icon_m07.gif"
                                        hoveredimageurl="~/Common/Images/Icon/icon_m07.gif"
                                        disabledimageurl="~/Common/Images/Icon/icon_m07.gif"
                                        checkedimageurl="~/Common/Images/Icon/icon_m07.gif"
                                        value="AddCondition">
                                    </telerik:radtoolbarbutton>
                                    <telerik:radtoolbarbutton runat="server" isseparator="True" text="Button 3" imageurl="~/App_Themes/DefaultTheme/images/toolbarSp.jpg">
                                    </telerik:radtoolbarbutton>
                                    <telerik:radtoolbarbutton runat="server" text="刪除表單條件" meta:resourcekey="TBarButtonResource3"
                                        imageurl="~/Common/Images/Icon/icon_m03.gif"
                                        hoveredimageurl="~/Common/Images/Icon/icon_m03.gif"
                                        disabledimageurl="~/Common/Images/Icon/icon_m03.gif"
                                        checkedimageurl="~/Common/Images/Icon/icon_m03.gif"
                                        value="DeleteCondition">
                                    </telerik:radtoolbarbutton>
                                    <telerik:radtoolbarbutton runat="server" isseparator="True" text="Button 4" imageurl="~/App_Themes/DefaultTheme/images/toolbarSp.jpg">
                                    </telerik:radtoolbarbutton>
                                    <telerik:radtoolbarbutton runat="server" disabledimageurl="~/Common/Images/Icon/icon_m38.gif"
                                        hoveredimageurl="~/Common/Images/Icon/icon_m38.gif" imageurl="~/Common/Images/Icon/icon_m38.gif"
                                        value="SortCondition" meta:resourcekey="TBarButtonResource4" checkedimageurl="~/Common/Images/Icon/icon_m38.gif"
                                        text="調整順序">
                                    </telerik:radtoolbarbutton>
                                    <telerik:radtoolbarbutton runat="server" isseparator="True" text="Button 5" imageurl="~/App_Themes/DefaultTheme/images/toolbarSp.jpg">
                                    </telerik:radtoolbarbutton>
                                    <telerik:radtoolbarbutton runat="server"
                                        value="Culture"
                                        text="設定條件多國語"
                                        hoveredimageurl="~/Common/Images/Icon/icon_j02.gif"
                                        imageurl="~/Common/Images/Icon/icon_j02.gif"
                                        checkedimageurl="~/Common/Images/Icon/icon_j02.gif"
                                        disabledimageurl="~/Common/Images/Icon/icon_j02.gif"
                                        meta:resourcekey="TBarButtonResource5">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton runat="server" IsSeparator="True" Text="Button 6" ImageUrl="~/App_Themes/DefaultTheme/images/toolbarSp.jpg">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton runat="server"
                                        Value="ExportCond"
                                        Text="匯出條件"
                                        HoveredImageUrl="~/Common/Images/Icon/icon_m144.gif"
                                        ImageUrl="~/Common/Images/Icon/icon_m144.gif"
                                        CheckedImageUrl="~/Common/Images/Icon/icon_m144.gif"
                                        DisabledImageUrl="~/Common/Images/Icon/icon_m144.gif"
                                        meta:resourcekey="TBarButtonResource6">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton runat="server" IsSeparator="True" Text="Button 7" ImageUrl="~/App_Themes/DefaultTheme/images/toolbarSp.jpg">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton runat="server"
                                        Value="ImportCond"
                                        Text="批次更新簡稱"
                                        HoveredImageUrl="~/Common/Images/Icon/icon_m110.gif"
                                        ImageUrl="~/Common/Images/Icon/icon_m110.gif"
                                        CheckedImageUrl="~/Common/Images/Icon/icon_m110.gif"
                                        DisabledImageUrl="~/Common/Images/Icon/icon_m110.gif"
                                        meta:resourcekey="TBarButtonResource7">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton runat="server" IsSeparator="True" Text="Button 8" ImageUrl="~/App_Themes/DefaultTheme/images/toolbarSp.jpg">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton Value="Tip">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCondDisableTip" runat="server" Text="*無法點選的條件名稱是不支援新增或修改的既有條件" ForeColor="Blue" meta:resourcekey="lblCondDisableTipResource1"></asp:Label>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>
                                </Items>

                            </telerik:RadToolBar>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 149px" valign="top">
                            <Fast:Grid runat="server" EnhancePager="True" Width="100%" DataKeyOnClientWithCheckBox="False" AllowSorting="True" PageSize="15" AutoGenerateCheckBoxColumn="True" AutoGenerateColumns="False" ID="Grid1" DataKeyNames="COND_ID" OnRowDataBound="Grid1_RowDataBound" OnRowCommand="Grid1_RowCommand">
                                <EnhancePagerSettings PageNumberCurrentCssClass="" NextImageUrl="" FirstImageUrl="" LastAltImage="" ShowHeaderPager="True" PageNumberCssClass="" PageInfoCssClass="" PreviousAltImageUrl="" PreviousImageUrl="" PageRedirectCssClass="" NextIAltImageUrl="" FirstAltImageUrl="" LastImageUrl=""></EnhancePagerSettings>
                                <Columns>
                                    <asp:TemplateField HeaderText="表單條件" meta:resourceKey="TemplateFieldResource1">
                                        <headerstyle width="60%"></headerstyle>
                                        <itemtemplate>
                                            <asp:LinkButton runat="server" ID="LinkButton1" Text='<%# Eval("COND_NAME") %>' meta:resourceKey="LinkButton1Resource1"></asp:LinkButton>
                                        </itemtemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="簡稱" meta:resourceKey="TemplateFieldResource6">
                                        <headerstyle width="20%"></headerstyle>
                                        <itemtemplate>
                                            <asp:Label runat="server" Text='<%# Bind("COND_ABBREVIATION") %>' ID="Label1"></asp:Label>
                                        </itemtemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="屬性" meta:resourceKey="TemplateFieldResource2">
                                        <edititemtemplate>
                                            <asp:TextBox runat="server" Text='<%# Bind("COND_ATTRIBUTE") %>' ID="TextBox2" meta:resourceKey="TextBox2Resource1"></asp:TextBox>
                                        </edititemtemplate>
                                        <itemstyle horizontalalign="Center"></itemstyle>
                                        <itemtemplate>
                                            <asp:Label runat="server" Text='<%# Bind("COND_ATTRIBUTE") %>' ID="dgItem_lblCondAttribute" Visible="False" meta:resourceKey="dgItem_lblCondAttributeResource1"></asp:Label>
                                            <asp:Label runat="server" ID="dgItem_lblCondAttributeName" meta:resourceKey="dgItem_lblCondAttributeNameResource1"></asp:Label>
                                        </itemtemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="False" meta:resourceKey="TemplateFieldResource3">
                                        <edititemtemplate>
                                            <asp:TextBox runat="server" Text='<%# Bind("COND_ID") %>' ID="TextBox1" meta:resourceKey="TextBox1Resource1"></asp:TextBox>



                                        </edititemtemplate>
                                        <itemtemplate>
                                            <asp:Label runat="server" Text='<%# Bind("COND_ID") %>' ID="dgItem_lblCondId" meta:resourceKey="dgItem_lblCondIdResource1"></asp:Label>



                                        </itemtemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="False" meta:resourceKey="TemplateFieldResource4">
                                        <edititemtemplate>
                                            <asp:TextBox runat="server" Text='<%# Bind("COMBINE_TYPE") %>' ID="TextBox3" meta:resourceKey="TextBox3Resource1"></asp:TextBox>



                                        </edititemtemplate>
                                        <itemtemplate>
                                            <asp:Label runat="server" Text='<%# Bind("COMBINE_TYPE") %>' ID="dgItem_lblcombineType" meta:resourceKey="dgItem_lblcombineTypeResource1"></asp:Label>



                                        </itemtemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="False" meta:resourceKey="TemplateFieldResource5">
                                        <edititemtemplate>
                                            <asp:TextBox runat="server" Text='<%# Bind("IS_COMBINED") %>' ID="TextBox4" meta:resourceKey="TextBox4Resource1"></asp:TextBox>



                                        </edititemtemplate>
                                        <itemtemplate>
                                            <asp:Label runat="server" Text='<%# Bind("IS_COMBINED") %>' ID="dgItem_lblIsCombined" meta:resourceKey="dgItem_lblIsCombinedResource1"></asp:Label>



                                        </itemtemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </Fast:Grid>
                        </td>
                    </tr>
                </tbody>
            </table>
        </contenttemplate>
        <triggers>
            <asp:ASYNCPOSTBACKTRIGGER EventName="ButtonClick" ControlID="RadToolBar1" />
        </triggers>
    </asp:UpdatePanel>
    <asp:Label ID="lblConfirmDelete" runat="server" Text="確定要刪除?" Visible="False" meta:resourcekey="lblConfirmDeleteResource1"></asp:Label>
    &nbsp;
    <asp:Label ID="lblFormCondition" runat="server"
        Text="1.設定表單條件>>" Visible="False" meta:resourcekey="lblFormConditionResource1"></asp:Label>
    <asp:Label ID="lblFormFlow" runat="server"
        Text="2.設定表單流程>>" Visible="False" meta:resourcekey="lblFormFlowResource1"></asp:Label>
    &nbsp;
    <asp:Label ID="lblSelf" runat="server" meta:resourcekey="lblSelfResource1" Text="自訂"
        Visible="False"></asp:Label>
    <asp:Label ID="lblSystem" runat="server" meta:resourcekey="lblSystemResource1" Text="系統"
        Visible="False"></asp:Label>
    <asp:Label ID="lblDeleteCondition" runat="server" meta:resourcekey="lblDeleteConditionResource1"
        Text="刪除的條件被流程所使用，不允許刪除" Visible="False"></asp:Label>
    <asp:Label ID="lblAddConditionBaseBtnValue" runat="server" Text="新增判斷式" Visible="false" meta:resourcekey="TBarButtonResource1"></asp:Label>
    <asp:Label ID="lblAddConditionBtnValue" runat="server" Text="新增條件" Visible="false" meta:resourcekey="TBarButtonResource2"></asp:Label>
    <asp:Label ID="lblSortConditionBtnValue" runat="server" Text="調整順序" Visible="false" meta:resourcekey="TBarButtonResource4"></asp:Label>
    <asp:Label ID="lblCultureBtnValue" runat="server" Text="設定條件多國語" Visible="false" meta:resourcekey="TBarButtonResource5"></asp:Label>
    <asp:Label ID="lblImportCondBtnValue" runat="server" Text="批次更新簡稱" Visible="false" meta:resourcekey="TBarButtonResource7"></asp:Label>
</asp:Content>

