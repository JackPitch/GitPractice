//
//  ReuseOutlets.swift
//  GitPractice
//
//  Created by Jackson Pitcher on 2/12/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class GetFollowersButton: UIButton {
    
    enum isBackgroundColored {
        case yes, no
    }
    
    init(backgroundColor: UIColor, title: String, coloredBackground: isBackgroundColored) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        
        layer.borderWidth = 4
        layer.cornerRadius = 12
        
        titleLabel?.font = .boldSystemFont(ofSize: 14)
        translatesAutoresizingMaskIntoConstraints = false
        
        switch coloredBackground {
        case .yes:
            titleLabel?.tintColor = .white
            titleLabel?.font = .preferredFont(forTextStyle: .headline)
            self.backgroundColor = backgroundColor
            layer.borderColor = backgroundColor.cgColor
        case .no:
            setTitleColor(backgroundColor, for: .normal)
            layer.borderColor = backgroundColor.cgColor
            titleLabel?.font = .preferredFont(forTextStyle: .headline)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FollowerAvatarImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        image = #imageLiteral(resourceName: "avatar-placeholder").withRenderingMode(.alwaysOriginal)
        clipsToBounds = true
        layer.cornerRadius = 16
        contentMode = .scaleAspectFit
    }
    
    let cache = Service.shared.cache
    
    func downloadImage(urlString: String) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        } else {
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, err) in
                guard let self = self else { return }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }
                guard let data = data else { return }
                
                guard let image = UIImage(data: data) else { return }
                self.cache.setObject(image, forKey: cacheKey)
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GetFollowersTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = .preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        placeholder = "Enter a username"
        
        returnKeyType = .go
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, size: CGFloat) {
        super.init(frame: .zero)
        text = title
        font = .boldSystemFont(ofSize: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Label: UILabel {
    init(title: String, size: CGFloat) {
        super.init(frame: .zero)
        text = title
        font = .systemFont(ofSize: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

