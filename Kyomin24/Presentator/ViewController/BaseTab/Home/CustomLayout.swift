//Created by Real Life Swift on 17/02/2019

import UIKit

protocol PinterestLayoutDelegate {
   func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout{
    
var delegate: PinterestLayoutDelegate?

   var controller: CategoryTableViewCell?
   var numberOfColumns: CGFloat = 2
   var cellPadding: CGFloat = 5.0

   private var contentHeight: CGFloat = 0.0
   private var contentWidth: CGFloat {
      let insets = collectionView!.contentInset
      return (collectionView!.bounds.width - (insets.left + insets.right))
   }

   private var attributesCache = [PinterestLayoutAttributes]()

   override func prepare() {
      if attributesCache.isEmpty {
         let columnWidth = contentWidth / numberOfColumns
         var xOffsets = [CGFloat]()
         for column in 0 ..< Int(numberOfColumns) {
            xOffsets.append(CGFloat(column) * columnWidth)
         }

         var column = 0
         var yOffsets = [CGFloat](repeating: 0, count: Int(numberOfColumns))

         for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

             let width = columnWidth - cellPadding * 2

            // Calculate the frame
            let photoHeight: CGFloat = (delegate?.collectionView(collectionView: collectionView!, heightForPhotoAt: indexPath, with: width))!


            let height = cellPadding + photoHeight + cellPadding
            let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            // Create layout attributes
            let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
            attributes.photoHeight = photoHeight
            attributes.frame = insetFrame
            attributesCache.append(attributes)

            // Update column, yOffest
            contentHeight = max(contentHeight, frame.maxY)
            yOffsets[column] = yOffsets[column] + height

            if column >= Int(numberOfColumns - 1) {
               column = 0
            } else {
               column += 1
            }
         }
      }
   }

   override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
   }

   override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      var layoutAttributes = [UICollectionViewLayoutAttributes]()

      for attributes in attributesCache {
         if attributes.frame.intersects(rect) {
            layoutAttributes.append(attributes)
         }
      }

      return layoutAttributes
   }

}

class PinterestLayoutAttributes : UICollectionViewLayoutAttributes {
   var photoHeight: CGFloat = 0.0

   override func copy(with zone: NSZone? = nil) -> Any {
      let copy = super.copy(with: zone) as! PinterestLayoutAttributes
      copy.photoHeight = photoHeight
      return copy
   }

   override func isEqual(_ object: Any?) -> Bool {
      if let attributes = object as? PinterestLayoutAttributes {
         if attributes.photoHeight == photoHeight {
            return super.isEqual(object)
         }
      }

      return false
   }
}
  
  
