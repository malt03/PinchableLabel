//
//  PinchableLabel.swift
//  PinchAndRotate
//
//  Created by Koji Murata on 2016/02/09.
//  Copyright © 2016年 Koji Murata. All rights reserved.
//

import UIKit

@objc public protocol PinchableLabelDelegate {
  @objc optional func pinchableLabelTouchesBegan(_ pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?)
  @objc optional func pinchableLabelTouchesMoved(_ pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?)
  @objc optional func pinchableLabelTouchesEnded(_ pinchableLabel: PinchableLabel, touches: Set<UITouch>, withEvent event: UIEvent?)
}

open class PinchableLabel: UILabel {
  // Making the hit area larger than the default hit area.
  open var tappableInset = UIEdgeInsets(top: -50, left: -50, bottom: -50, right: -50)
  
  // When bigger or smaller, does not re-rendering.
  // Large font is too heavy to render.
  // Small font emoji is not able to render.
  open var maxFontSize = CGFloat(800)
  open var minFontSize = CGFloat(22)
  
  open var lockRotate = false
  open var lockScale = false
  open var lockOriginX = false
  open var lockOriginY = false
  
  open var addingWidth = CGFloat(0)
  open var addingHeight = CGFloat(0)
  
  open var delegate: PinchableLabelDelegate?
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    isUserInteractionEnabled = true
    isMultipleTouchEnabled = true
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open func unlockAll() {
    lockRotate = false
    lockScale = false
    lockOriginX = false
    lockOriginY = false
  }
  
  fileprivate var beginSize: CGSize!
  fileprivate var beginFontSize: CGFloat!
  fileprivate var beginCenter: CGPoint!
  fileprivate var beginDistance = CGFloat(0)
  fileprivate var beginRadian = CGFloat(0)
  fileprivate var beginTransform = CGAffineTransform.identity
  fileprivate var lastRotateTransform = CGAffineTransform.identity
  fileprivate var lastScale = CGFloat(1)
  fileprivate var endRotateTransform = CGAffineTransform.identity
  fileprivate var endScale = CGFloat(1)
  
  fileprivate var activeTouches = [UITouch]()
  
  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let lastActiveTouchesCount = activeTouches.count
    for t in touches {
      activeTouches.append(t)
    }
    
    let transform = CGAffineTransformTranslateWithSize(self.transform, -bounds.size / 2)
    let location0 = activeTouches[0].location(in: self).applying(transform)
    
    beginSize = bounds.size
    beginFontSize = font.pointSize
    beginTransform = endRotateTransform
    lastRotateTransform = CGAffineTransform.identity
    lastScale = endScale
    
    if activeTouches.count == 1 {
      beginCenter = location0
    } else if lastActiveTouchesCount < 2 && activeTouches.count >= 2 {
      let location1 = activeTouches[1].location(in: self).applying(transform)
      var center: CGPoint?
      (beginDistance, beginRadian, center) = distanceRadianAndCenter(location0, location1)
      beginCenter = center
    }

    delegate?.pinchableLabelTouchesBegan?(self, touches: touches, withEvent: event)
  }
  
  override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    let location0 = activeTouches[0].location(in: superview)
    let c: CGPoint
    if activeTouches.count == 1 {
      c = location0 - beginCenter
    } else {
      let location1 = activeTouches[1].location(in: superview)
      let (distance, radian, location) = distanceRadianAndCenter(location0, location1)
      let scale = lockScale ? 1 : distance / beginDistance
      
      let rotate = lockRotate ? 0 : beginRadian - radian
      let locationInLabelFromCenter = beginCenter * scale
      
      lastScale = scale * endScale
      lastRotateTransform = CGAffineTransform(rotationAngle: rotate)
      let transform = CGAffineTransformScaleWithFloat(lastRotateTransform, lastScale)
      self.transform = beginTransform.concatenating(transform)
      c = location! - locationInLabelFromCenter.applying(lastRotateTransform)
    }

    if !lockOriginX { center.x = c.x }
    if !lockOriginY { center.y = c.y }
    
    delegate?.pinchableLabelTouchesMoved?(self, touches: touches, withEvent: event)
  }
  
  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches {
      activeTouches.remove(at: activeTouches.index(of: t)!)
    }
    if activeTouches.count < 2 {
      endRotateTransform = beginTransform.concatenating(lastRotateTransform)
      
      let fontSize = beginFontSize * lastScale
      if fontSize < minFontSize || maxFontSize < fontSize {
        endScale = lastScale
      } else {
        endScale = 1
        self.transform = endRotateTransform
        let t = NSMutableAttributedString(attributedString: attributedText!)
        t.applyScaleToFont(fontSize / font.pointSize)
        
        attributedText = t
        sizeFitToTextSize()
      }
      if activeTouches.count == 1 {
        let transform = CGAffineTransformTranslateWithSize(self.transform, -bounds.size / 2)
        beginCenter = activeTouches[0].location(in: self).applying(transform)
      }
    }

    delegate?.pinchableLabelTouchesEnded?(self, touches: touches, withEvent: event)
  }
  
  open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    touchesEnded(touches, with: event)
  }
  
  override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    if activeTouches.count > 0 { return true }
    var rect = bounds
    rect.origin.x += tappableInset.left / endScale
    rect.origin.y += tappableInset.top / endScale
    rect.size.width -= (tappableInset.left + tappableInset.right) / endScale
    rect.size.height -= (tappableInset.top + tappableInset.bottom) / endScale
    return rect.contains(point)
  }
  
  func sizeFitToTextSize() {
    let s = attributedText!.size()
    bounds.size = CGSize(width: s.width + addingWidth, height: s.height + addingHeight)
  }
}

extension NSMutableAttributedString {
  func applyScaleToFont(_ scale: CGFloat) {
    var i = 0
    while i < length {
      var range = NSRange()
      let font = attribute(NSFontAttributeName, at: i, effectiveRange: &range) as! UIFont
      let kern = (attribute(NSKernAttributeName, at: i, effectiveRange: nil) as? NSNumber).map { $0.floatValue } ?? 0
      addAttributes([
        NSFontAttributeName: font.withSize(font.pointSize * scale),
        NSKernAttributeName: NSNumber(value: kern * Float(scale))
      ], range: range)
      i = range.location + range.length
    }
  }
}

private func distanceRadianAndCenter(_ a: CGPoint, _ b: CGPoint) -> (CGFloat, CGFloat, CGPoint?) {
  let diff = a - b
  let distance = sqrt(diff.x * diff.x + diff.y * diff.y)
  let radian = atan2(diff.x, diff.y)
  let center = (a + b) / 2
  return (distance, radian, center)
}

private func CGAffineTransformTranslateWithSize(_ transform: CGAffineTransform, _ size: CGSize) -> CGAffineTransform {
  return transform.translatedBy(x: size.width, y: size.height)
}

private func CGAffineTransformScaleWithFloat(_ transform: CGAffineTransform, _ float: CGFloat) -> CGAffineTransform {
  return transform.scaledBy(x: float, y: float)
}

private func +(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

private func -(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

private func *(left: CGPoint, right: CGFloat) -> CGPoint {
  return CGPoint(x: left.x * right, y: left.y * right)
}

private func /(left: CGPoint, right: CGFloat) -> CGPoint {
  return CGPoint(x: left.x / right, y: left.y / right)
}

private func *(left: CGSize, right: CGFloat) -> CGSize {
  return CGSize(width: left.width * right, height: left.height * right)
}

private func /(left: CGSize, right: CGFloat) -> CGSize {
  return CGSize(width: left.width / right, height: left.height / right)
}

private func -(left: CGPoint, right: CGSize) -> CGPoint {
  return CGPoint(x: left.x - right.width, y: left.y - right.height)
}

prefix func -(size: CGSize) -> CGSize {
  return CGSize(width: -size.width, height: -size.height)
}
