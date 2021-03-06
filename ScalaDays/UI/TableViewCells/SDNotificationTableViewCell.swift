import UIKit

class SDNotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var timelineTop: UIView!
    @IBOutlet weak var timelineMiddle: UIView!
    @IBOutlet weak var timelineBotton: UIView!
    
    @IBOutlet weak var bullet: UIView!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    
    private var position: CellPosition = .only { didSet { updateTimelineView() }}
        
    func draw(notification: SDNotification, position: CellPosition) {
        setupStyle()
        updateBulletState(isPending: Date() < notification.date)
        
        self.position = position
        self.time.text = time(date: notification.date)
        self.date.text = day(date: notification.date)
        self.title.text = notification.title
        self.message.text = notification.message
    }
    
    // MARK: setup appareance
    private func setupStyle() {
        timelineTop.backgroundColor = UIColor.appRedColor()
        timelineMiddle.backgroundColor = UIColor.appRedColor()
        timelineBotton.backgroundColor = UIColor.appRedColor()
        time.textColor = UIColor.appRedColor()
        date.textColor = UIColor.appRedColor()
    }
    
    private func updateBulletState(isPending: Bool) {
        bullet.layer.cornerRadius = bullet.frame.width * 0.5
        bullet.layer.borderColor = UIColor.appRedColor().cgColor
        bullet.layer.borderWidth = 1.25
        bullet.backgroundColor = isPending ? .white : UIColor.appRedColor()
    }
    
    private func updateTimelineView() {
        switch position {
        case .top:
            timelineTop.isHidden = false
            timelineMiddle.isHidden = true
            timelineBotton.isHidden = true
        case .middle:
            timelineTop.isHidden = true
            timelineMiddle.isHidden = false
            timelineBotton.isHidden = true
        case .bottom:
            timelineTop.isHidden = true
            timelineMiddle.isHidden = true
            timelineBotton.isHidden = false
        case .only:
            timelineTop.isHidden = true
            timelineMiddle.isHidden = true
            timelineBotton.isHidden = true
        }
    }
    
    // MARK: helpers <DateFormatter>
    private func time(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
    
    private func day(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
