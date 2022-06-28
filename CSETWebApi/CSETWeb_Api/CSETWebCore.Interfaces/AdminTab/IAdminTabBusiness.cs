using CSETWebCore.Model.AdminTab;
using CSETWebCore.DataLayer.Model;

namespace CSETWebCore.Interfaces.AdminTab
{
    public interface IAdminTabBusiness
    {
        AdminTabData GetTabData(int assessmentId);
        void SaveDataAttribute(int assessmentId, AttributePair att);
    }
}