<%@ Page Title="" Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" CodeBehind="SendEdocModifyRecordDialog.aspx.cs" Inherits="Ede.Uof.Web.Edoc.SendDoc.SendEdocModifyRecordDialog" %>

<%@ Register Assembly="Ede.Uof.Utility.Component.Grid" Namespace="Ede.Uof.Utility.Component" TagPrefix="Fast" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <Fast:Grid ID="grdEdocUpdateRecord" runat="server" Width="100%" DataKeyNames="SEND_DOC_ID"
        EmptyDataText="沒有資料" AutoGenerateColumns="false" PageSize="15" AllowPaging="True" AutoGenerateCheckBoxColumn="false"
         OnRowDataBound="grdEdocUpdateRecord_RowDataBound" 
         OnBeforeExport="grdEdocUpdateRecord_BeforeExport" AllowSorting="false">
        <ExportExcelSettings AllowExportToExcel="True" />
        <HeaderStyle Wrap="false" />
        <Columns>
            <asp:TemplateField HeaderText="異動型態" >
                <ItemTemplate>
                    <asp:Label ID="lblUpdateType" runat="server"></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Wrap="False" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="異動前" >
                <ItemTemplate>
                    <asp:Label ID="lblModifyBefore" runat="server"></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Wrap="False" />
            </asp:TemplateField>

             <asp:TemplateField HeaderText="異動後" >
                <ItemTemplate>
                    <asp:Label ID="lblModifyAfter" runat="server"></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Wrap="False" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="修改者" >
                <ItemTemplate>
                    <asp:Label ID="lblModifyUser" runat="server"></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" Wrap="False" />
            </asp:TemplateField>

            <asp:BoundField DataField="MODIFY_FROM" HeaderText="IP">
                <ItemStyle HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>

            <asp:TemplateField HeaderText="修改時間" >
                <ItemTemplate>
                    <asp:Label ID="lblModofyDate" runat="server"></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" Wrap="False" />
            </asp:TemplateField>

            <asp:BoundField DataField="MODIFY_REASON" HeaderText="修改原因">
                <ItemStyle HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>


        </Columns>
    </Fast:Grid>
    <asp:HiddenField ID="hfSendDocId" runat="server" />
</asp:Content>
