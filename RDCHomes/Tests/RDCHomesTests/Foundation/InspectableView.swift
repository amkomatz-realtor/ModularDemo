import ViewInspector
import RDCCore

extension InspectableView {
    func locate(_ id: any IAccessibilityId) throws -> InspectableView<ViewType.ClassifiedView> {
        try find(viewWithAccessibilityIdentifier: id.stringValue)
    }
}
