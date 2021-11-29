//
//  TestingVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/27.
//

import UIKit
import Alamofire
import AVFoundation

class TestingVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    
    var questionSlides: [LoveTestQuestion] = []
    var urlImage: UIImage?
    var testResultCount: Int = 0
    var avPlayer = AVAudioPlayer()
    var testCategory: TestCategory?
    var delegate: SendDataDelegate?
    var imageUrlString: String = ""
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureTestButton(trueButton, imageName: "circle", backgroundColor: .systemBlue)
        configureTestButton(falseButton, imageName: "xmark", backgroundColor: .systemRed)
        initAudio()
        avPlayer.play()
//        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveNotification(_:)), name: NSNotification.Name("didRecieveNotification"), object: nil)
    }
    
    @objc func didRecieveNotification(_ notification: Notification) {
        guard let receiveData = notification.userInfo else { return }
        
        guard let receiveText: String = receiveData["imagURL"] as? String else { return }
 
        imageUrlString = receiveText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false

        setQuestionSlide()
        
        pageControl.numberOfPages = questionSlides.count
    }
    
    func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .customPink
        navigationController?.navigationBar.topItem?.title = "뒤로"
        
        let musicButton = UIBarButtonItem(image: UIImage(systemName: "speaker.slash"), style: .plain, target: self, action: #selector(musicPause))
        musicButton.tintColor = .customPink
        self.navigationItem.rightBarButtonItem = musicButton
    }
    
    func initAudio() {
        guard let sound = NSDataAsset(name: "funMusic") else { return }
        do {
            try avPlayer = AVAudioPlayer(data: sound.data)
            avPlayer.prepareToPlay()
        } catch {
            print("error")
        }
    }
    
    @objc func musicPause() {
        if avPlayer.isPlaying {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "speaker.3")
            avPlayer.pause()
        } else {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "speaker.slash")
            avPlayer.play()
        }
    }
    
    func configureTestButton(_ testButton: UIButton, imageName: String, backgroundColor: UIColor) {
        testButton.layer.cornerRadius = 10
        testButton.backgroundColor = backgroundColor
        testButton.setImage(UIImage(systemName: imageName), for: .normal)
        testButton.tintColor = .white
        testButton.contentVerticalAlignment = .center
        testButton.contentHorizontalAlignment = .center
    }
    
    @IBAction func trueBtnClicked(_ sender: UIButton) {
        testResultCount += 1
        if currentPage == questionSlides.count - 1 {
            //avPlayer.stop()
            guard let storyboard = self.storyboard else { return }
            guard let resultVC =  storyboard.instantiateViewController(withIdentifier: "TestResultVC") as? TestResultVC else { return }
            resultVC.modalTransitionStyle = .coverVertical
            resultVC.modalPresentationStyle = .fullScreen
            self.delegate = resultVC
            
            delegate?.sendData(testResultCount: testResultCount, category: testCategory!)
            
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func falseBtnClicked(_ sender: UIButton) {
        testResultCount -= 1
        if currentPage == questionSlides.count - 1 {
            //avPlayer.stop()
            guard let storyboard = self.storyboard else { return }
            guard let resultVC =  storyboard.instantiateViewController(withIdentifier: "TestResultVC") as? TestResultVC else { return }
            resultVC.modalTransitionStyle = .coverVertical
            resultVC.modalPresentationStyle = .fullScreen
            
            self.delegate = resultVC
            
            delegate?.sendData(testResultCount: testResultCount, category: testCategory!)
            
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func getImage(closure: @escaping () -> Void) {
        AlamofireManager.shared.session.request(UnsplashRouter.searchPhotos(term: "loves")).validate(statusCode: 200...399).responseJSON { response in
            switch response.result {
            case .success:
                guard let result = response.data else { return }

                do {
                    let json = try JSONDecoder().decode(NetworkResults.self, from: result)

                    print(json.results[1].urls.small)
                    //NotificationCenter.default.post(name: NSNotification.Name("didRecieveNotification"), object: nil, userInfo: ["imagURL": json.results[1].urls.small])
                    //self.getUrlToImage(urlString: json.results[1].urls.small)
                    closure()
                } catch {
                    print("error!\(error)")
                }
            case .failure:
                return
            }
        }
        
    }
    
    func getUrlToImage(urlString: String) -> UIImage {
        let url = URL(string: urlString)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch {
            print("error")
        }
        return UIImage(named: "logo")!
    }

}

extension TestingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionSlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoveTestCollecionViewCell.identifier, for: indexPath) as? LoveTestCollecionViewCell else { return UICollectionViewCell() }
        
        cell.setup(questionSlides[indexPath.row])
        
        AlamofireManager.shared.session.request(UnsplashRouter.searchPhotos(term: "loves")).validate(statusCode: 200...399).responseJSON { response in
            switch response.result {
            case .success:
                guard let result = response.data else { return }

                do {
                    let json = try JSONDecoder().decode(NetworkResults.self, from: result)
                    let url = URL(string: json.results[indexPath.row].urls.small)
                    do {
                        let data = try Data(contentsOf: url!)
                        let image = UIImage(data: data)!
                        DispatchQueue.main.async {
                            guard let cellIndex = collectionView.indexPath(for: cell),
                                  cellIndex == indexPath else { return }
                            
                            cell.slideImageView.image = image
                        }
                        
                    } catch {
                    }
                } catch {
                    print("error!\(error)")
                }
            case .failure:
                return
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}


//MARK: - 테스트 데이터
extension TestingVC {
    func setQuestionSlide() {
        switch testCategory {
        case .marriage:
            marriedQuestion()
        case .ability:
            abilityQuestion()
        case .attachment:
            attachmentQuestion()
        case .none:
            print("error")
        }
    }
    
    func marriedQuestion() {
        questionSlides = [
            LoveTestQuestion(question: "결혼을 한다면 1년안에 하고 싶은가요?", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "자신은 스몰웨딩을 원하시나요?", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "신혼여행은 해외로 가고싶은가요?", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "혼수는 무조건 반반인가요?", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "아이를 낳고 싶은가요?", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "집안일 배분은 소득순으로 하나요?", image: UIImage(named: "logo")!)
        ]
    }
    
    func attachmentQuestion() {
        questionSlides = [
            LoveTestQuestion(question: "나는 버림을 받는 것에 대해 걱정하는 편이다", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "다른 사람에게 의지하기가 어렵다", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "나는 상대방에게 모든 것을 이야기한다.", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "상대방이 나에게 불안을 나타낼 때 나 자신이 정말 형편없게 느껴진다.", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "나는 위로와 확신을 비롯한 많은 일들을 상대방에게 의지한다", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "상대방이 나를 떠나서 많은 시간을 보냈을 때 나는 불쾌하다", image: UIImage(named: "logo")!)
        ]
    }
    
    func abilityQuestion() {
        questionSlides = [
            LoveTestQuestion(question: "주말에 약속이 없다면 집에 있는다", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "데이트를 할 때 옷을 신경쓰는 편이다", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "소개팅에서 말을 먼저하는 편이다", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "리뷰를 보고 맛집을 찾는 편이다", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "애인이 집에 오는 경우 청소를 하는 편이다", image: UIImage(named: "logo")!),
            LoveTestQuestion(question: "애인의 친구에게 편하게 대하는 편이다", image: UIImage(named: "logo")!)
        ]
    }
    
}
