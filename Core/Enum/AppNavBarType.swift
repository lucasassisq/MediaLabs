// MARK: - Enums

public enum AppNavBarType: Equatable {
    /** < _ */
    case back

    /** <_ Title*/
    case backAndTitle

    /** < _ Title > ->Button */
    case backAndTextAndRightButton

    /** Title -> RightButton */
    case title

    /** Title -> RightButton */
    case titleAndRight

    case none
}
