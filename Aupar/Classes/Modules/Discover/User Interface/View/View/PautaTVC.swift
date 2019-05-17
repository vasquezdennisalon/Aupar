//
//  SwipeTableViewCell.swift
//
//  Created by Jeremy Koch
//  Copyright © 2017 Jeremy Koch. All rights reserved.
//

import UIKit

open class SwipeTableViewCell: UITableViewCell {
    @IBOutlet weak var margin: UIView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var enfasis: UILabel!
    @IBOutlet weak var linea: UIView!
    
    /*
     var favorito:Bool = false
     var esCupon:Bool = false
     var canjeados:Int = 0
     var canjeables:Int = 0
     var id:String = ""
     var _titulo:String = ""
     var _texto:String = ""
     var _enfasis:String = ""
     var envio_id:String = ""
     var tipo:Int = 1
     var favoritoCallback:((SwipeTableViewCell)->Void)?
     var ticketCallback:((SwipeTableViewCell)->Void)?
     */
    var objeto:Interaccion?
    var showNotLongEnoughModal:(()->Void)?
    @IBOutlet weak var fondo: UIView!
    @IBOutlet weak var fondoImagen: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var fondoShadow: UIView!
    
    @IBOutlet weak var ticketController: UIView!
    @IBOutlet weak var ticketButton: UIButton!
    @IBOutlet weak var betweenTicket: NSLayoutConstraint!
    @IBOutlet weak var textoHeight: NSLayoutConstraint!
    @IBOutlet weak var ticketWidth: NSLayoutConstraint!
    @IBOutlet weak var favoriteButtonWidthConstraint: NSLayoutConstraint!
    /// The object that acts as the delegate of the `SwipeTableViewCell`.
    public weak var delegate: SwipeTableViewCellDelegate?
    
    @IBOutlet weak var ticketView: UIView!
    @IBOutlet weak var ticketViewLeft: RoundView!
    @IBOutlet weak var ticketViewRight: RoundView!
    var ticketCheckTimeout:Timer?
    
    @IBOutlet weak var roundView: RoundView!
    @IBOutlet weak var roundViewHeight: NSLayoutConstraint!
    @IBOutlet weak var roundViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var cuponBorder: CuponBorder!
    @IBOutlet weak var cuponesCanjeadosLbl: UILabel!
    @IBOutlet weak var cuponesCanjeablesLbl: UILabel!
    
    @IBOutlet weak var generar_cupon_label: UILabel!
    @IBOutlet weak var canjes_label: UILabel!
    var animator: SwipeAnimator?
    
    
    var state = SwipeState.center
    var originalCenter: CGFloat = 0
    var ticketTimer:Date?
    
    weak var tableView: UITableView?
    var actionsView: SwipeActionsView?
    var orilla:UIView?
    var path:UIBezierPath?
    
    var originalLayoutMargins: UIEdgeInsets = .zero
    var imageDownload:UIImage? = nil
    
    
    lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        gesture.delegate = self
        return gesture
    }()
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        gesture.delegate = self
        return gesture
    }()
    
    lazy var ticketSmallPressGestureRecognizer:UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTicketSmallPress(gesture:)))
        gesture.delegate = self
        gesture.minimumPressDuration = 0
        return gesture
    }()
    
    //
    
    let elasticScrollRatio: CGFloat = 0.4
    var scrollRatio: CGFloat = 1.0
    
    /// :nodoc:
    override open var center: CGPoint {
        didSet {
            actionsView?.visibleWidth = abs(frame.minX)
        }
    }
    
    /// :nodoc:
    open override var frame: CGRect {
        set { super.frame = state.isActive ? CGRect(origin: CGPoint(x: frame.minX, y: newValue.minY), size: newValue.size) : newValue }
        get { return super.frame }
    }
    
    /// :nodoc:
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    @IBAction func favoritePressed(_ sender: Any) {
        self.setFavorito(favorito: false)
    }
    
    deinit {
        tableView?.panGestureRecognizer.removeTarget(self, action: nil)
    }
    override open func awakeFromNib() {
        super.awakeFromNib()
        /*translation*/
        self.generar_cupon_label.text = NSLocalizedString("coupon_generate_coupon", comment: "Texto que dice generar cupon")
        self.canjes_label.text = NSLocalizedString("coupon_redeems_coupon", comment:"Texto que dice canjes")
        //self.backgroundColor = options.
        // Initialization code
        self.favoriteButtonWidthConstraint.constant = 0
        //self.favoriteButton.mask = self.fondo
        linea.addDashedLine(strokeColor: Utilities.shared.naranja, lineWidth: 4, fullscreen: true)
        //para el fondo
        let radius: CGFloat = self.fondo.frame.height / 2.0 //change it to .height if you need spread for height
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.fondo.frame.width, height: 2.01 * radius))
        
        self.fondo.layer.cornerRadius = 5
        self.fondo.layer.masksToBounds = true
        
        self.fondoShadow.layer.cornerRadius = 5
        self.fondoShadow.layer.shadowColor = UIColor.black.cgColor
        self.fondoShadow.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        self.fondoShadow.layer.shadowOpacity = 0.2
        self.fondoShadow.layer.masksToBounds =  false
        self.fondoShadow.layer.shadowPath = shadowPath.cgPath
        
        //para la imagen
        let radius_img: CGFloat = self.imagen.frame.height / 2.0 //change it to .height if you need spread for height
        let shadowPath_img = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.imagen.frame.width, height: 2.01 * radius_img))
        
        self.imagen.image = #imageLiteral(resourceName: "aupar-placeholder-image")
        self.imagen.layer.cornerRadius = 5
        self.imagen.layer.masksToBounds =  false
        self.imagen.clipsToBounds = true
        
        self.fondoImagen.layer.cornerRadius = 5
        self.fondoImagen.layer.shadowColor = UIColor.black.cgColor
        self.fondoImagen.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        self.fondoImagen.layer.shadowOpacity = 0.2
        self.fondoImagen.layer.shadowPath = shadowPath_img.cgPath
        self.fondoImagen.layer.masksToBounds = false
        
        self.isUserInteractionEnabled = true
        ticketButton.addGestureRecognizer(ticketSmallPressGestureRecognizer)
        roundViewWidth.constant = 10
        roundViewHeight.constant = 10
    }
    
    func configure() {
        clipsToBounds = false
        addGestureRecognizer(tapGestureRecognizer)
        addGestureRecognizer(panGestureRecognizer)
        
    }
    
    func setObjeto(objeto:Interaccion){
        self.objeto = objeto
        self.titulo.text = objeto.titulo
        self.texto.text = objeto.texto
        self.enfasis.text = objeto.enfasis
        if objeto.esCupon == true{
            self.roundView.alpha = 0
            self.ticketViewLeft.alpha = 1
            self.ticketViewRight.alpha = 1
            self.roundViewWidth.constant = 10
            self.roundViewHeight.constant = 10
            self.roundView.layer.cornerRadius = 5
            self.layoutIfNeeded()
            self.cuponBorder.setNeedsDisplay()
            self.textoHeight.constant = 30
            self.texto.numberOfLines = 2
            self.linea.isHidden = true
            self.betweenTicket.constant = -4
            self.ticketWidth.constant = 30
            self.ticketController.isHidden = false
            self.enfasis.isHidden = true
            //self.cuponesCanjeadosLbl.text = "\(objeto.generados)"
            //self.cuponesCanjeablesLbl.text = "\(objeto.generables)"
            self.favoriteButtonWidthConstraint.constant = 0
        }else{
            if(objeto.favorito == false){
                self.favoriteButtonWidthConstraint.constant = 0
            }else{
                self.favoriteButtonWidthConstraint.constant = 32
            }
            self.cuponBorder.setNeedsDisplay()
            self.textoHeight.constant = 40
            self.texto.numberOfLines = 3
            self.linea.isHidden = false
            self.betweenTicket.constant = 0
            self.ticketWidth.constant = 0
            self.ticketController.isHidden = true
            self.enfasis.isHidden = false
            self.cuponesCanjeadosLbl.text = "0"
            self.cuponesCanjeablesLbl.text = "0"
        }
    }
    
    
    func setFavorito(favorito:Bool){
        if let obj = self.objeto{
            self.objeto?.favorito = favorito
            if (favorito){
                /*if let cb = obj.likeActionCB{
                    cb(obj)
                }*/
            }else{
                /*if let cb = obj.dislikeActionCB{
                    cb(obj)
                }*/
            }
        }
    }
    
    func pushImage(image: UIImage){
        UIView.transition(with: self.imagen,
                          duration: 1,
                          options: .transitionCrossDissolve,
                          animations: { self.imagen.image = image },
                          completion: nil)
    }
    
    func likeAnimation(delay:CGFloat, completion: @escaping ()->Void){
        self.favoriteButtonWidthConstraint.constant = 32
        UIView.animate(withDuration: 0.25, delay: TimeInterval(delay), options: [], animations: {
            self.layoutIfNeeded()
        }, completion:{finished in
            completion()
        })
    }
    
    func dislikeAnimation(delay:CGFloat, completion:@escaping ()->Void){
        self.favoriteButtonWidthConstraint.constant = 0
        UIView.animate(withDuration: 0.25, delay: TimeInterval(delay), options: [], animations: {
            self.layoutIfNeeded()
        }, completion:{finished in
            completion()
        })
    }
    
    /// :nodoc:
    override open func prepareForReuse() {
        super.prepareForReuse()
        
        reset()
        self.imagen.image = #imageLiteral(resourceName: "aupar-placeholder-image")
    }
    
    /// :nodoc:
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        var view: UIView = self
        while let superview = view.superview {
            view = superview
            
            if let tableView = view as? UITableView {
                self.tableView = tableView
                
                tableView.panGestureRecognizer.removeTarget(self, action: nil)
                tableView.panGestureRecognizer.addTarget(self, action: #selector(handleTablePan(gesture:)))
                return
            }
        }
    }
    
    /// :nodoc:
    override open func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            hideSwipe(animated: false)
        }
    }
    
    @objc func handleTicketSmallPress(gesture:UILongPressGestureRecognizer){
        if (gesture.state == UIGestureRecognizer.State.began){
            self.ticketTimer = Date()
            self.roundView.layer.removeAllAnimations()
            self.ticketViewLeft.layer.removeAllAnimations()
            self.ticketViewRight.layer.removeAllAnimations()
            self.roundView.alpha = 0
            roundViewWidth.constant = 60
            roundViewHeight.constant = 60
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.layoutIfNeeded()
                self.roundView.layer.cornerRadius = 30
                self.roundView.alpha = 1
                self.ticketViewLeft.alpha = 0
                self.ticketViewRight.alpha = 0
            },completion:{
                complete in
                self.roundViewWidth.constant = 100
                self.roundViewHeight.constant = 100
                UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
                    self.roundView.layer.cornerRadius = 50
                    self.layoutIfNeeded()
                })
            })
            /*ticketCheckTimeout = Utilities.shared.setTimeout(3.0){
                self.ticketWasPressedEnough()
            }*/
        }else if (gesture.state == UIGestureRecognizer.State.ended){
            self.ticketCheckTimeout?.invalidate()
            self.roundView.layer.removeAllAnimations()
            self.ticketViewLeft.layer.removeAllAnimations()
            self.ticketViewRight.layer.removeAllAnimations()
            if(self.roundViewWidth.constant > 100){
                print("end do action")
            }else{
                if let cb = self.showNotLongEnoughModal{
                    cb()
                }
            }
            roundViewWidth.constant = 10
            roundViewHeight.constant = 10
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.layoutIfNeeded()
                self.roundView.layer.cornerRadius = 5
                self.roundView.alpha = 0
                self.ticketViewLeft.alpha = 1
                self.ticketViewRight.alpha = 1
            })
        }
    }
    
    
    
    func ticketWasPressedEnough(){
        self.roundView.layer.removeAllAnimations()
        self.ticketViewLeft.layer.removeAllAnimations()
        self.ticketViewRight.layer.removeAllAnimations()
        /*if let cb = objeto?.generaCuponCB{
            cb(self.objeto!)
        }*/
        //animate full
        self.roundViewWidth.constant = 500
        self.roundViewHeight.constant = 500
        UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
            self.roundView.layer.cornerRadius = 250
            self.layoutIfNeeded()
        })
    }
    
    func ticketPressedEnough()-> Bool{
        let elapsed = Date().timeIntervalSince(self.ticketTimer!)
        if elapsed >= 3.0{
            return true
        }else{
            return false
        }
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        guard isEditing == false else { return }
        guard let target = gesture.view else { return }
        
        switch gesture.state {
        case .began:
            stopAnimatorIfNeeded()
            
            originalCenter = center.x
            
            if state == .center || state == .animatingToCenter {
                let velocity = gesture.velocity(in: target)
                let orientation: SwipeActionsOrientation = velocity.x > 0 ? .left : .right
                
                showActionsView(for: orientation)
                
            }
            
        case .changed:
            guard let actionsView = actionsView else { return }
            
            let translation = gesture.translation(in: target).x
            scrollRatio = 1.0
            
            // Check if dragging past the center of the opposite direction of action view, if so
            // then we need to apply elasticity
            if (translation + originalCenter - bounds.midX) * actionsView.orientation.scale > 0 {
                target.center.x = gesture.elasticTranslation(in: target,
                                                             withLimit: .zero,
                                                             fromOriginalCenter: CGPoint(x: originalCenter, y: 0)).x
                scrollRatio = elasticScrollRatio
                return
            }
            
            if let expansionStyle = actionsView.options.expansionStyle {
                let expanded = expansionStyle.shouldExpand(view: self, gesture: gesture, in: tableView!)
                let targetOffset = expansionStyle.targetOffset(for: self, in: tableView!)
                let currentOffset = abs(translation + originalCenter - bounds.midX)
                
                if expanded && !actionsView.expanded && targetOffset > currentOffset {
                    let centerForTranslationToEdge = bounds.midX - targetOffset * actionsView.orientation.scale
                    let delta = centerForTranslationToEdge - originalCenter
                    
                    animate(toOffset: centerForTranslationToEdge)
                    gesture.setTranslation(CGPoint(x: delta, y: 0), in: superview!)
                } else {
                    target.center.x = gesture.elasticTranslation(in: target,
                                                                 withLimit: CGSize(width: targetOffset, height: 0),
                                                                 fromOriginalCenter: CGPoint(x: originalCenter, y: 0),
                                                                 applyingRatio: expansionStyle.targetOverscrollElasticity).x
                }
                
                actionsView.setExpanded(expanded: expanded, feedback: true)
            } else {
                target.center.x = gesture.elasticTranslation(in: target,
                                                             withLimit: CGSize(width: actionsView.preferredWidth, height: 0),
                                                             fromOriginalCenter: CGPoint(x: originalCenter, y: 0),
                                                             applyingRatio: elasticScrollRatio).x
                if (target.center.x - originalCenter) / translation != 1.0 {
                    scrollRatio = elasticScrollRatio
                }
            }
        case .ended:
            guard let actionsView = actionsView else { return }
            
            let velocity = gesture.velocity(in: target)
            state = targetState(forVelocity: velocity)
            
            if actionsView.expanded == true, let expandedAction = actionsView.expandableAction  {
                perform(action: expandedAction)
            } else {
                let _targetOffset = targetCenter(active: state.isActive)
                let targetOffset = _targetOffset
                let distance = targetOffset - center.x
                let normalizedVelocity = velocity.x * scrollRatio / distance
                animate(toOffset: targetOffset, withInitialVelocity: normalizedVelocity) { _ in
                    if self.state == .center {
                        self.reset()
                    }
                }
                
                if !state.isActive {
                    notifyEditingStateChange(active: false)
                }
            }
            
        default: break
        }
    }
    
    @discardableResult
    func showActionsView(for orientation: SwipeActionsOrientation) -> Bool {
        guard let tableView = tableView,
            let indexPath = tableView.indexPath(for: self),
            let actions = delegate?.tableView(tableView, editActionsForRowAt: indexPath, for: orientation),
            actions.count > 0
            else {
                return false
        }
        
        originalLayoutMargins = super.layoutMargins
        
        // Remove highlight and deselect any selected cells
        super.setHighlighted(false, animated: false)
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        selectedIndexPaths?.forEach { tableView.deselectRow(at: $0, animated: false) }
        
        // Temporarily remove table gestures
        // tableView.setGestureEnabled(false)
        
        configureActionsView(with: actions, for: orientation)
        
        return true
    }
    
    func configureActionsView(with actions: [SwipeAction], for orientation: SwipeActionsOrientation) {
        guard let tableView = tableView,
            let indexPath = tableView.indexPath(for: self) else { return }
        
        let options = delegate?.tableView(tableView, editActionsOptionsForRowAt: indexPath, for: orientation) ?? SwipeTableOptions()
        
        self.orilla?.removeFromSuperview()
        self.orilla = nil
        self.actionsView?.removeFromSuperview()
        self.actionsView = nil
        
        
        
        let actionsView = SwipeActionsView(maxSize: bounds.size,
                                           options: options,
                                           orientation: orientation,
                                           actions: actions)
        
        actionsView.delegate = self
        
        //self.margin.insertSubview(actionsView, belowSubview: self.fondoShadow)
        self.insertSubview(actionsView, at: 0)
        actionsView.heightAnchor.constraint(equalTo: self.fondo.heightAnchor).isActive = true
        actionsView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2).isActive = true
        actionsView.topAnchor.constraint(equalTo: self.fondo.topAnchor).isActive = true
        
        if orientation == .left {
            actionsView.rightAnchor.constraint(equalTo: self.fondoImagen.leftAnchor, constant: 4).isActive = true
        } else {
            actionsView.leftAnchor.constraint(equalTo: self.favoriteButton.rightAnchor, constant: -4).isActive = true
        }
        self.actionsView = actionsView
        //Orilla
        
        let orilla = UIView(frame: .zero)
        orilla.clipsToBounds = false
        orilla.translatesAutoresizingMaskIntoConstraints = false
        orilla.backgroundColor = actionsView.backgroundColor
        var orillad2:UIView?
        if( orientation == .left){
            orillad2 = UIView(frame: CGRect(x: 4, y: 0, width: 11, height: self.fondo.frame.size.height))
        }else{
            orillad2 = UIView(frame: CGRect(x: -6, y: 0, width: 11, height: self.fondo.frame.size.height))
        }
        orillad2!.backgroundColor = actions[0].backgroundColor
        orillad2!.layer.cornerRadius = 5
        orilla.addSubview(orillad2!)
        /*
         let orilla2 = CAShapeLayer()
         
         let path = UIBezierPath(roundedRect:CGRect(x: 0, y: 0, width: 5, height: self.fondo.frame.size.height), byRoundingCorners: [.topRight,.bottomRight], cornerRadii: CGSize(width: 5, height: 5))
         //self.margin.insertSubview(orilla, aboveSubview: self.fondo)
         orilla2.path = path.cgPath
         orilla2.fillColor = actions[0].backgroundColor?.cgColor
         orilla.layer.addSublayer(orilla2)
         */
        self.insertSubview(orilla, at: 1)
        //self.margin.insertSubview(orilla, belowSubview: self.fondoShadow)
        
        orilla.topAnchor.constraint(equalTo: self.fondo.topAnchor).isActive = true
        orilla.heightAnchor.constraint(equalTo: self.fondo.heightAnchor).isActive = true
        if let sp = Utilities.shared.getCurrentViewController(){
            if orientation == .left {
                orilla.leftAnchor.constraint(equalTo: sp.view.leftAnchor).isActive = true
            }else{
                orilla.rightAnchor.constraint(equalTo: sp.view.rightAnchor).isActive = true
            }
        }
        
        let orillawidth = NSLayoutConstraint(item: orilla, attribute: NSLayoutConstraint.Attribute.width,
                                             relatedBy: NSLayoutConstraint.Relation.equal,
                                             toItem: nil,
                                             attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                             multiplier: 1,
                                             constant: 9)
        self.orilla = orilla
        addConstraint(orillawidth)
        state = .dragging
        
        notifyEditingStateChange(active: true)
    }
    
    func notifyEditingStateChange(active: Bool) {
        guard let actionsView = actionsView,
            let tableView = tableView,
            let indexPath = tableView.indexPath(for: self) else { return }
        
        if active {
            delegate?.tableView(tableView, willBeginEditingRowAt: indexPath, for: actionsView.orientation)
        } else {
            delegate?.tableView(tableView, didEndEditingRowAt: indexPath, for: actionsView.orientation)
        }
    }
    func hide(duration: Double = 0.7, withInitialVelocity velocity: CGFloat = 0, completion: ((Bool) -> Void)? = nil) {
        let animator: SwipeAnimator = {
            if velocity != 0 {
                if #available(iOS 10, *) {
                    let velocity = CGVector(dx: velocity, dy: velocity)
                    let parameters = UISpringTimingParameters(mass: 1.0, stiffness: 100, damping: 18, initialVelocity: velocity)
                    return UIViewPropertyAnimator(duration: 0.0, timingParameters: parameters)
                } else {
                    return UIViewSpringAnimator(duration: duration, damping: 1.0, initialVelocity: velocity)
                }
            } else {
                if #available(iOS 10, *) {
                    return UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0)
                } else {
                    return UIViewSpringAnimator(duration: duration, damping: 1.0)
                }
            }
        }()
        
        animator.addAnimations({
            self.orilla?.alpha = 0
        })
        
        if let completion = completion {
            animator.addCompletion(completion: completion)
        }
        
        //self.animator = animator
        
        animator.startAnimation()
    }
    
    
    func animate(duration: Double = 0.7, toOffset offset: CGFloat, withInitialVelocity velocity: CGFloat = 0, completion: ((Bool) -> Void)? = nil) {
        stopAnimatorIfNeeded()
        
        layoutIfNeeded()
        
        let animator: SwipeAnimator = {
            if velocity != 0 {
                if #available(iOS 10, *) {
                    let velocity = CGVector(dx: velocity, dy: velocity)
                    let parameters = UISpringTimingParameters(mass: 1.0, stiffness: 100, damping: 18, initialVelocity: velocity)
                    return UIViewPropertyAnimator(duration: 0.0, timingParameters: parameters)
                } else {
                    return UIViewSpringAnimator(duration: duration, damping: 1.0, initialVelocity: velocity)
                }
            } else {
                if #available(iOS 10, *) {
                    return UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0)
                } else {
                    return UIViewSpringAnimator(duration: duration, damping: 1.0)
                }
            }
        }()
        
        animator.addAnimations({
            self.center = CGPoint(x: offset, y: self.center.y)
            
            self.layoutIfNeeded()
        })
        
        if let completion = completion {
            animator.addCompletion(completion: completion)
        }
        
        self.animator = animator
        
        animator.startAnimation()
    }
    
    func stopAnimatorIfNeeded() {
        if animator?.isRunning == true {
            animator?.stopAnimation(true)
        }
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        hideSwipe(animated: true)
    }
    
    @objc func handleTablePan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            hideSwipe(animated: true)
        }
    }
    
    // Override so we can accept touches anywhere within the cell's minY/maxY.
    // This is required to detect touches on the `SwipeActionsView` sitting alongside the
    // `SwipeTableCell`.
    /// :nodoc:
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let superview = superview else { return false }
        
        let point = convert(point, to: superview)
        
        if !UIAccessibility.isVoiceOverRunning {
            for cell in tableView?.swipeCells ?? [] {
                if (cell.state == .left || cell.state == .right) && !cell.contains(point: point) {
                    tableView?.hideSwipeCell()
                    return false
                }
            }
        }
        
        return contains(point: point)
    }
    
    func contains(point: CGPoint) -> Bool {
        return point.y > frame.minY && point.y < frame.maxY
    }
    
    /// :nodoc:
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if state == .center {
            super.setHighlighted(highlighted, animated: animated)
        }
    }
    
    /// :nodoc:
    override open var layoutMargins: UIEdgeInsets {
        get {
            return frame.origin.x != 0 ? originalLayoutMargins : super.layoutMargins
        }
        set {
            super.layoutMargins = newValue
        }
    }
}

extension SwipeTableViewCell {
    func targetState(forVelocity velocity: CGPoint) -> SwipeState {
        guard let actionsView = actionsView else { return .center }
        
        switch actionsView.orientation {
        case .left:
            return (velocity.x < 0 && !actionsView.expanded) ? .center : .left
        case .right:
            return (velocity.x > 0 && !actionsView.expanded) ? .center : .right
        }
    }
    
    func targetCenter(active: Bool) -> CGFloat {
        guard let actionsView = actionsView, active == true else { return bounds.midX }
        
        return bounds.midX - actionsView.preferredWidth * actionsView.orientation.scale
    }
    
    func reset() {
        state = .center
        
        //tableView?.setGestureEnabled(true)
        orilla?.removeFromSuperview()
        actionsView?.removeFromSuperview()
        
        actionsView = nil
        orilla = nil
    }
}

extension SwipeTableViewCell: SwipeActionsViewDelegate {
    func swipeActionsView(_ swipeActionsView: SwipeActionsView, didSelect action: SwipeAction) {
        perform(action: action)
    }
    
    func perform(action: SwipeAction) {
        guard let actionsView = actionsView else { return }
        
        if action == actionsView.expandableAction, let expansionStyle = actionsView.options.expansionStyle {
            // Trigger the expansion (may already be expanded from drag)
            actionsView.setExpanded(expanded: true)
            
            switch expansionStyle.completionAnimation {
            case .bounce:
                perform(action: action, hide: true)
            case .fill(let fillOption):
                performFillAction(action: action, fillOption: fillOption)
            }
        } else {
            perform(action: action, hide: action.hidesWhenSelected)
        }
    }
    
    func perform(action: SwipeAction, hide: Bool) {
        guard let tableView = tableView, let indexPath = tableView.indexPath(for: self) else { return }
        
        if hide {
            hideSwipe(animated: true)
        }
        
        action.handler?(action, indexPath)
    }
    
    func performFillAction(action: SwipeAction, fillOption: SwipeExpansionStyle.FillOptions) {
        guard let actionsView = actionsView,
            let tableView = tableView,
            let indexPath = tableView.indexPath(for: self) else { return }
        
        let newCenter = bounds.midX - (bounds.width + actionsView.minimumButtonWidth) * actionsView.orientation.scale
        
        action.completionHandler = { [weak self] style in
            action.completionHandler = nil
            
            self?.delegate?.tableView(tableView, didEndEditingRowAt: indexPath, for: actionsView.orientation)
            
            switch style {
            case .delete:
                self?.mask = actionsView.createDeletionMask()
                
                tableView.deleteRows(at: [indexPath], with: .none)
                
                UIView.animate(withDuration: 0.3, animations: {
                    self?.center.x = newCenter
                    self?.mask?.frame.size.height = 0
                    
                    if fillOption.timing == .after {
                        actionsView.alpha = 0
                    }
                }) { [weak self] _ in
                    self?.mask = nil
                    self?.reset()
                }
            case .reset:
                self?.hideSwipe(animated: true)
            }
        }
        
        let invokeAction = {
            action.handler?(action, indexPath)
            
            if let style = fillOption.autoFulFillmentStyle {
                action.fulfill(with: style)
            }
        }
        
        animate(duration: 0.3, toOffset: newCenter) { _ in
            if fillOption.timing == .after {
                invokeAction()
            }
        }
        
        if fillOption.timing == .with {
            invokeAction()
        }
    }
}

extension SwipeTableViewCell {
    /// :nodoc:
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == tapGestureRecognizer {
            if UIAccessibility.isVoiceOverRunning {
                tableView?.hideSwipeCell()
            }
            
            let cell = tableView?.swipeCells.first(where: { $0.state.isActive })
            return cell == nil ? false : true
        }
        
        if gestureRecognizer == panGestureRecognizer,
            let view = gestureRecognizer.view,
            let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer
        {
            let translation = gestureRecognizer.translation(in: view)
            return abs(translation.y) <= abs(translation.x)
        }
        
        return true
    }
}
