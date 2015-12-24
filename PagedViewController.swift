//
//  PagedViewController.swift
//  ScrollViewTest
//
//  Created by Kan Chen on 12/24/15.
//  Copyright © 2015 Kan Chen. All rights reserved.
//

import UIKit

class PagedViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var pageController: UIPageControl!

    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        // Do any additional setup after loading the view.
        pageImages = [UIImage(named: "photo1.png")!,
                UIImage(named: "photo2.png")!,
                UIImage(named: "photo3.png")!,
                UIImage(named: "photo4.png")!,
                UIImage(named: "photo5.png")!]

        let pageCount = pageImages.count

        pageController.currentPage = 0
        pageController.numberOfPages = pageCount

        for _ in 0..<pageCount {
            pageViews.append(nil)
        }

        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: pagesScrollViewSize.height)


        loadVisiblePages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadVisiblePages() {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2 + pageWidth) / (pageWidth * 2.0)))

        pageController.currentPage = page

        let firstPage = page-1
        let lastPage = page+1

        for var index = 0; index < firstPage; index++ {
            purgePage(index)
        }

        for index in firstPage...lastPage {
            loadPage(index)
        }

        for var index = lastPage+1; index < pageImages.count; index++ {
            purgePage(index)
        }
    }

    func loadPage(page:Int) {
        if page < 0 || page >= pageImages.count {
            return
        }

        if let pageView = pageViews[page] {

        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0

            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)

            pageViews[page] = newPageView
        }
    }

    func purgePage(page:Int) {
        if page < 0 || page >= pageImages.count {
            return
        }

        if let pageview = pageViews[page] {
            pageview.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        loadVisiblePages()
    }
    
}
