
import UIKit

public class SlideSegmentedView: UIStackView {
    public var currentIndexChanged: ((Int) -> Void)?
    
    /// DO NOT use this property to set index, use setCurrentIndex(_:)
    public var currentIndex: Int = .max
    
    var maxNumber: Int = 20
    public var numberOfSegments: Int = 10 {
        didSet {
            addItemView()
        }
    }
    
    /// 是否只响应在视图内的手势事件，默认为 false
    public var touchPointStrict: Bool = false
    
    /// 未选中情况下的背景色
    public var normalColor: UIColor = UIColor(white: 0.95, alpha: 1)
    
    /// 被选中时的背景色
    public var selectedColor: UIColor = UIColor.black
    
    /// 开始几个元素的背景色，优先级大于选中时的背景色，数组长度n代表前n个元素背景色为数组中的对应颜色
    public var startColors: [UIColor] = []
    
    /// 结尾元素的背景色，优先级大于选中时的背景色，数组长度n代表后n个元素的背景色为数组中对应颜色
    public var endColors: [UIColor] = []
    
    public var segmentRadius: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    private func initUI() {
        spacing = 2
        distribution = .fillEqually
        alignment = .fill
        
        addGestures()
    }
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAction)
        )
        
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(panAction)
        )
        
        addGestureRecognizer(tapGesture)
        addGestureRecognizer(panGesture)
    }
    
    private func addItemView() {
        arrangedSubviews.forEach({ $0.removeFromSuperview() })
        for _ in 0..<numberOfSegments {
            let itemView = makeView()
            addArrangedSubview(itemView)
        }
        setCurrentIndex(0)
    }
    
    private func makeView() -> UIView {
        let view = UIView()
        view.backgroundColor = normalColor
        view.layer.cornerRadius = segmentRadius
        return view
    }
}


extension SlideSegmentedView {
    public func setCurrentIndex(_ index: Int) {
        // 确保index在 arrangedSubviews 的长度范围之内
        guard index != currentIndex, index < arrangedSubviews.count else { return }
        currentIndex = index
        let itemView = arrangedSubviews[index]
        animateItem(itemView)
        currentIndexChanged?(index)
        // 改变选择时震动反馈
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    /// 选项改变时，改变背景色、transform等
    /// - Parameter itemView: 被选中的view
    private func animateItem(_ itemView: UIView) {
        arrangedSubviews.forEach({ $0.backgroundColor = normalColor })
        itemView.backgroundColor = selectedColor
        for i in 0..<startColors.count {
            if i >= arrangedSubviews.count {
                break
            }
            arrangedSubviews[i].backgroundColor = startColors[i]
        }
        
        for i in 0..<endColors.count {
            let index = arrangedSubviews.count - i - 1
            if index >= arrangedSubviews.count {
                break
            }
            arrangedSubviews[index].backgroundColor = endColors[i]
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.arrangedSubviews.forEach({ $0.transform = .identity })
            itemView.transform = .init(scaleX: 1.1, y: 1.1)
        } completion: { isFinished in
            
        }

    }
}



extension SlideSegmentedView {
    @objc
    private func tapAction(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: sender.view)
        handleGestureTouchPoint(touchPoint)
    }
    
    @objc
    private func panAction(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            let touchPoint = sender.location(in: sender.view)
            handleGestureTouchPoint(touchPoint)
        default:
            break
        }
    }
    
    private func handleGestureTouchPoint(_ point: CGPoint) {
        let index = locatedIndex(point)
        if index != -1 {
            setCurrentIndex(index)
        }
    }
    
    /// 根据手势的触摸点计算当前所处的index位置
    /// - Parameter point: 手势触摸点
    /// - Returns: item 的 index
    private func locatedIndex(_ point: CGPoint) -> Int {
        for item in arrangedSubviews.enumerated() {
            // 此处主要是看根据x坐标判断还是整个点来判断
            if touchPointStrict {
                if item.element.frame.contains(point) {
                    return item.offset
                }
            } else {
                if (item.element.frame.minX...item.element.frame.maxX).contains(point.x) {
                    return item.offset
                }
            }
        }
        return -1
    }
}
