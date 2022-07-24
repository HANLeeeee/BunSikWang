//
//  ViewController.swift
//  Game_BunSikWang
//
//  Created by 하늘이 on 2022/07/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var bgmPlayer: AVAudioPlayer!
    
    @IBOutlet weak var labelMainTimer: UILabel!

    @IBOutlet weak var viewMe: UIView!
    @IBOutlet weak var imageViewMyMenu: UIImageView!
    
    @IBOutlet weak var viewHall: UIView!
    
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnDown: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet var tableS: [UIImageView]!
    @IBOutlet var tableMenuS: [UIImageView]!
    @IBOutlet var progressViewS: [UIProgressView]!
    
    @IBOutlet var viewMenuS: [UIView]!
    @IBOutlet var imageViewMenuSelectedS: [UIImageView]!
    
    @IBOutlet weak var labelCost: UILabel!
    @IBOutlet weak var labelPerson: UILabel!
    @IBOutlet weak var labelLike: UILabel!
    @IBOutlet weak var labelDDuk: UILabel!
    @IBOutlet weak var labelKimbab: UILabel!
    @IBOutlet weak var labelSoondae: UILabel!
    @IBOutlet weak var labelNoodle: UILabel!
    @IBOutlet weak var labelFry: UILabel!
    
    var scoreCost: Int = 0
    var scorePerson: Int = 0
    var scoreLike: Int = 0
    var scoreDDuk: Int = 0
    var scoreKimbab: Int = 0
    var scoreSoondae: Int = 0
    var scoreNoodle: Int = 0
    var scoreFry: Int = 0
    
    var oneStep: CGFloat = 0.0
    
    var hour = 09
    var minutes = 00
    
    var myMenu: String = ""
    let arrayMenuImage = [UIImage(named: "menu_dduk"), UIImage(named: "menu_kimbab"), UIImage(named: "menu_soondae"), UIImage(named: "menu_noodle"), UIImage(named: "menu_fry"), UIImage(named: "menu_danmuji"), UIImage()]
    var arrayMenu = ["떡볶이", "김밥", "순대", "라면", "튀김", "단무지", ""]
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initCustomer()

        mainTimer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playBGM()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        bgmPlayer.stop()
    }
    
    func initUI() {
        //내 캐릭터 한걸음 설정
        oneStep = (viewHall.frame.height/7)-5
        
        //홀 테두리
        viewHall.layer.borderWidth = 8
        viewHall.layer.borderColor = UIColor.yellow.cgColor
        
        //테이블타이머 초기화
        progressViewS.forEach {
            $0.transform = CGAffineTransform(rotationAngle: .pi / 2)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.white.cgColor
            $0.isHidden = true
            $0.progress = 0
        }
        
        //내가 가지고 있는 메뉴 초기화
        imageViewMyMenu.image = UIImage()
        
        //테이블의 메뉴 초기화
        tableMenuS.forEach {
            $0.image = UIImage()
        }
        
        menuSelected()
        
    }
    
    func menuSelected() {
        //메뉴화살표 초기화
        imageViewMenuSelectedS.forEach {
            $0.isHidden = true
        }
    }
    
    //MARK: 테이블 데이터 초기화
    func initCustomer() {
        
        for num in 0..<6 {
            customerData.append(Customer(tableImageView: tableS[num], exist: false, state: "주문전", menu: "단무지", menuImageView: tableMenuS[num], tableTimer: progressViewS[num], timerStart: true))
        }
      
    }
    
    func playBGM() {
        guard let url = Bundle.main.url(forResource: "mainBGM", withExtension: "mp3") else {
            print("파일에러")
            return
        }
        
        do {
            bgmPlayer = try AVAudioPlayer(contentsOf: url)
            
            bgmPlayer.numberOfLoops = -1
            bgmPlayer.play()
        } catch {
            print("파일에러")
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------
    //MARK: 메인 쓰레드
    func mainTimer() {
        //MARK: 전체 타이머 재생
        DispatchQueue.global().async {
            //1. UI가 변경되기 전에 실행
            while self.hour < 18 {
                self.minutes += 01
                if self.minutes > 59 {
                    self.hour += 1
                    self.minutes = 0
                }
                DispatchQueue.main.sync {
            //2. UI업데이트
                    self.labelMainTimer.text = "\(String(format: "%02d", self.hour)) : \(String(format: "%02d", self.minutes))"
                }
            //3. UI 변경 후 실행
//                print("게임시간흐르는중")
                usleep(200000)
                //빠르게
//                usleep(10000)
            }
        }
       
        //MARK: 랜덤 테이블에 손님 생성
        DispatchQueue.global().async {
            //전체 타이머의 시간이 되기 전까지 반복문 실행
            while self.hour < 18 {
                //테이블 위치를 랜덤으로 받음
//                let indexNum = 2
                let indexNum = Int.random(in: 0..<customerData.count)
                //여기 담긴 시간만큼 기다렸다가 테이블에 손님생성!
                usleep(3000000)
                if customerData[indexNum].exist == false {
                    DispatchQueue.main.sync {
                        print("\(indexNum)")
                        self.scorePersonSum()
                        self.scoreLikePlus(num: 3)
                        customerData[indexNum].tableImageView.image = UIImage(named: "icon_coming")
                        customerData[indexNum].exist = true
                        customerData[indexNum].tableTimer.isHidden = false
                        
                    }
                    print("\(indexNum)테이블 손님생성")
                    self.tableTimer(tableIndex: indexNum)

                } else {
                    print("\(indexNum)테이블에 사람있음")
                }
            }
        }
    }
    
    //MARK: 테이블 타이머 재생 20초
    func tableTimer(tableIndex: Int) {
        print("\(tableIndex) 타이머시작")
        DispatchQueue.global().async {
            var tableTime: Float = 0.0
            while tableTime < 1 {
                if customerData[tableIndex].state != "치우기" && customerData[tableIndex].state != "식사끝" {
                    DispatchQueue.main.sync {
                        if customerData[tableIndex].timerStart == false {
                            tableTime = 1
                        } else {
//                            print("\(tableIndex)테이블 손님타이머시작")
                            customerData[tableIndex].tableTimer.progress = tableTime
                            customerData[tableIndex].tableTimer.setProgress(tableTime, animated: true)
                        }
                    }
                    tableTime += 0.05
                    usleep(1000000) //1초
                    //빠르게
//                    usleep(100000)
                    
                } else {
//                    print("식사중일때")
                    tableTime += 0.2
                    usleep(1000000) //1초
                }
            }
            //대기시간이 끝났을 때
            customerData[tableIndex].timerStart = true
            self.orderIng(tableIndex: tableIndex)
        }
    }
    
    func orderIng(tableIndex: Int) {
        let menuIndex = Int.random(in: 0...4)
        
        DispatchQueue.main.sync {
            switch customerData[tableIndex].state {
            case "주문전":
                print("\(tableIndex) 기분상함")
                self.scoreLikeMinus(num: 1)
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_upset")
                customerData[tableIndex].state = "주문전1"
                
            case "주문전1":
                print("\(tableIndex) 매우화남")
                self.scoreLikeMinus(num: 2)
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_angry")
                customerData[tableIndex].state = "주문전2"

            case "주문중":
                print("\(tableIndex) 주문")
                self.scoreLikePlus(num: 3)
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_order")
                customerData[tableIndex].menuImageView.image = arrayMenuImage[menuIndex]
                customerData[tableIndex].menu = arrayMenu[menuIndex]
                customerData[tableIndex].state = "주문중1"
           
            case "주문중1":
                print("\(tableIndex) 주문중 기분상함")
                self.scoreLikeMinus(num: 1)
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_upset")
                customerData[tableIndex].state = "주문중2"
                
            case "주문중2":
                print("\(tableIndex) 주문중 매우화남")
                self.scoreLikeMinus(num: 2)
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_angry")
                customerData[tableIndex].state = "주문중3"
                
            case "식사중":
                print("\(tableIndex) 냠냠")
                self.scoreLikePlus(num: 3)
                customerData[tableIndex].tableTimer.isHidden = true
                
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_eating")
                customerData[tableIndex].menuImageView.image = UIImage()
                customerData[tableIndex].state = "식사끝"

            case "식사끝":
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_finish")
                self.tableTimer(tableIndex: tableIndex)
                customerData[tableIndex].state = "치우기"

            case "치우기":
                print("\(tableIndex)테이블 내메뉴는 \(myMenu)")
                scoreSum(scoreMenu: myMenu)
                
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_dirty")
                customerData[tableIndex].menu = "치우기"
                myMenu = ""

                
            default:
                //나갔을 때 & state="주문전2"일때 & state="주문중3"일때
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_empty")
                customerData[tableIndex].exist = false
                customerData[tableIndex].state = "주문전"
                customerData[tableIndex].menu = "단무지"
                customerData[tableIndex].menuImageView.image = UIImage()
                customerData[tableIndex].tableTimer.isHidden = true
                gameOver()
                
            }
        }
        
    }
   
  
    //-------------------------------------------------------------------------------------------------------------------------------------

    func scoreSum(scoreMenu: String) {
        scoreCost += 2000
        labelCost.text = numberFormatter(number: scoreCost)
        
        switch scoreMenu {
        case "떡볶이":
            scoreDDuk += 1
            labelDDuk.text = String(scoreDDuk)
            
        case "김밥":
            scoreDDuk += 1
            labelDDuk.text = String(scoreDDuk)
        
        case "순대":
            scoreSoondae += 1
            labelSoondae.text = String(scoreSoondae)
            
        case "라면":
            scoreNoodle += 1
            labelNoodle.text = String(scoreNoodle)
            
        case "튀김":
            scoreFry += 1
            labelFry.text = String(scoreFry)
            
        default:
            return
        }
    }
    
    func scorePersonSum() {
        scorePerson += 2
        labelPerson.text = String(scorePerson)
    }
    
    func scoreLikePlus(num: Int) {
        scoreLike += num
        labelLike.text = String(scoreLike)
    }
    
    func scoreLikeMinus(num: Int) {
        scoreLike -= num
        labelLike.text = String(scoreLike)
    }
    
    func gameOver() {
        //마감
        if hour == 18 {
            var existCheck: [Bool] = []
            for index in 0..<customerData.count {
                existCheck.append(customerData[index].exist)
            }
            guard existCheck.contains(true) else {
                print("게임오버~~")
                
                let resultViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerReult") as! ViewControllerReult
                
                resultViewController.modalPresentationStyle = .fullScreen
                self.present(resultViewController, animated: true)
                

                return
            }
        }
    }
    
    
    
    //버튼이벤트
    @IBAction func btnSubmitAction(_ sender: Any) {
        tablePosition()
        menuPosition()
    }

    @IBAction func btnUpAction(_ sender: Any) {
        viewMe.layer.position = CGPoint(x: viewMe.center.x, y: viewMe.center.y-oneStep)
        tablePosition()
        menuPosition()
    }
    @IBAction func btnRightAction(_ sender: Any) {
        viewMe.layer.position = CGPoint(x: viewMe.center.x+oneStep, y: viewMe.center.y)
        tablePosition()
        menuPosition()
    }
    @IBAction func btnLeftAction(_ sender: Any) {
        viewMe.layer.position = CGPoint(x: viewMe.center.x-oneStep, y: viewMe.center.y)
        tablePosition()
        menuPosition()
    }
    @IBAction func btnDownAction(_ sender: Any) {
        viewMe.layer.position = CGPoint(x: viewMe.center.x, y: viewMe.center.y+oneStep)
        tablePosition()
        menuPosition()
    }
    
    func tablePosition() {
        let point = CGPoint(x: Int(viewMe.center.x)-10, y: Int(viewMe.center.y+10))
        for num in 0..<tableS.count {
            if tableS[num].frame.contains(point) {
                print("\(num)번 테이블 접근")
                menuPick(tableIndex: num)
            }
        }
    }
    
    func menuPick(tableIndex: Int) {
        if btnSubmit.isTouchInside {
            print("제출버튼클릭")
            if customerData[tableIndex].menu == "단무지" && myMenu == "단무지" {
                customerData[tableIndex].timerStart = false
                customerData[tableIndex].state = "주문중"
                myMenu = ""
                imageViewMyMenu.image = UIImage()
                
                
            } else if customerData[tableIndex].menu == myMenu {
                customerData[tableIndex].timerStart = false
                customerData[tableIndex].state = "식사중"
                imageViewMyMenu.image = UIImage()
                
            } else if customerData[tableIndex].menu == "치우기" && myMenu == "" {
                customerData[tableIndex].tableImageView.image = UIImage(named: "icon_empty")
                customerData[tableIndex].exist = false
                customerData[tableIndex].state = "주문전"
                customerData[tableIndex].menu = "단무지"
                
                gameOver()
                
                
            } else {
                print("갖고있는 거랑 시킨메뉴랑 다름")
            }
        }
    }
    

    func menuPosition() {
        menuSelected()

        let point = CGPoint(x: Int(viewMe.center.x-25), y: Int(viewMe.center.y))
        for num in 0..<viewMenuS.count {
            if viewMenuS[num].frame.contains(point) {
                print("\(num)번 \(arrayMenu[num]) 접근")
                setImageViewMenuSelected(imageViewMenuSelected: imageViewMenuSelectedS[num])
                setImageMyMenu(num: num)
            }
        }
    }
    
    //제출하기 눌렀을 때 가지고 있는 메뉴 변경
    func setImageMyMenu(num: Int) {
        if num < 6 {
            if btnSubmit.isTouchInside && imageViewMyMenu.image == UIImage() {
                imageViewMyMenu.image = arrayMenuImage[num]
                myMenu = arrayMenu[num]
            }
            
        } else {
            if btnSubmit.isTouchInside {
                imageViewMyMenu.image = UIImage()
                myMenu = arrayMenu[num]
            }
        }
        
    }
    
    //메뉴 화살표 표시
    func setImageViewMenuSelected(imageViewMenuSelected: UIImageView) {
        for num in 0..<imageViewMenuSelectedS.count {
            if imageViewMenuSelected == imageViewMenuSelectedS[num] {
                imageViewMenuSelectedS[num].isHidden = false
            } else {
                imageViewMenuSelectedS[num].isHidden = true
            }
        }
    }
}
