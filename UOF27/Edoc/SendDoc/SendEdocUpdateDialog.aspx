<%@ Page Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" CodeBehind="SendEdocUpdateDialog.aspx.cs" Inherits="Ede.Uof.Web.Edoc.SendDoc.SendEdocUpdateDialog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width="100%" class="PopTable" cellspacing="1">
        <tr>
            <td style="height: 35px;" class="PopTableLeftTD" nowrap="nowrap">
                    <asp:Label runat="server" ID="LabelRedPoint1" Text="*" ForeColor="Red"></asp:Label>
                    <asp:Label ID="Label1" runat="server" Text="變更後發文日期"></asp:Label>
                </td>
                <td style="height: 35px;" class="PopTableRightTD" nowrap="nowrap">
                    <telerik:RadDatePicker ID="rdpSendDocDate" runat="server"></telerik:RadDatePicker>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="rdpSendDocDate" Display="Dynamic" ErrorMessage="請選擇日期" 
                        SetFocusOnError="True" ></asp:RequiredFieldValidator>
                </td>
        </tr>
        <tr>
                <td style="height: 80px;" class="PopTableLeftTD" nowrap="nowrap">
                    <asp:Label runat="server" ID="LabelRedPoint2" Text="*" ForeColor="Red"></asp:Label>
                    <asp:Label ID="lblChangeForm" runat="server" Text="變更原因"></asp:Label>
                </td>
                <td style="height: 80px;" class="PopTableRightTD" nowrap="nowrap">
                    <asp:TextBox ID="tbxModfiyReason" runat="server" TextMode="MultiLine"
                        Width="100%" Height="80px" MaxLength="225"
                        ></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="tbxModfiyReason" Display="Dynamic" ErrorMessage="必填" 
                        SetFocusOnError="True" >必填</asp:RequiredFieldValidator>
                </td>
        </tr>
        <tr>
                <td style="height: 35px;" class="PopTableLeftTD" nowrap="nowrap">
                    <asp:Label ID="Label2" runat="server" Text="異動人員"></asp:Label>
                </td>
                <td style="height: 35px;" class="PopTableRightTD" nowrap="nowrap">
                    <asp:Label ID="lblModifyUser" Text="" runat="server" />
                </td>
        </tr>
    </table>
<asp:CustomValidator runat="server" ID="cvSettingCheck" ErrorMessage="未啟用「電子公文→基本設定」中【允許機關管理員變更公文發文日期】的設定，請洽電子公文管理員。" Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
</asp:Content>

