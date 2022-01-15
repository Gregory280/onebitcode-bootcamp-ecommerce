class Samples
  class SystemRequirements
    def self.storage
      ['500 GB', '800 GB', '1 TB', '2 TB'].sample
    end
    def self.processor
      [
        'AMD Ryzen 3 5300G', 'AMD Ryzen 3 PRO 5350G', 'AMD Ryzen 5 5500U',
        'AMD Ryzen 5 PRO 5650G', 'AMD Ryzen 7 5700U', 'AMD Ryzen 9 5900', 'AMD Ryzen 3 3100',
        'AMD Ryzen 5 3500', 'AMD Ryzen 5 1600 AF', 'AMD Ryzen 7 2700E0', 'AMD Ryzen Threadripper 1920X',
        'Intel Pentium MMX', 'Intel Celeron', 'Pentium 4', 'Intel® Core™ i7-6900K',
        'Intel® Core™ i7-5930K', 'Intel Core i9 Q3', 'Intel® Core™ i9-7960X X-series'
      ].sample
    end
    def self.memory
      ['2 GB', '4 GB', '8 GB', '12 GB'].sample
    end
    def self.video_board
      [
        'Radeon RX 550 2 GB', 'GTX 1050 Ti 4 GB ', 'GTX 1650 4 GB',
        'ATI Radeon RX 580 8 GB', 'GTX 1660 Super 6 GB', 'RTX 2060 6 GB',
        'RTX 2080 Super 8 GB', 'AMD Radeon RX 6800 16 GB', 'RTX 3080 10 GB'
      ].sample
    end
  end

end