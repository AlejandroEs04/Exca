import { ChangeEvent, useState } from "react"

type Option = {
    label: string
    value: string | number
}

export type PushEvent = {
    target: {
        name: string
        value: string | number
    }
}

type InputGroupProps = {
    id?: string
    name: string
    value: string | number
    type?: 'text' | 'number' | 'email' | 'password' | 'date' | 'tel'
    placeholder: string
    label: string
    options?: Option[]
    disable?: boolean
    onChangeFnc: (e: ChangeEvent<HTMLInputElement> | PushEvent) => void
}

export default function InputGroup({ 
        name, 
        id = name, 
        value, 
        type = 'text', 
        placeholder,
        label,
        onChangeFnc, 
        options = [],
        disable = false
    } : InputGroupProps) 
{
    const [show, setShow] = useState(false)
    const [optionsFiltered, setOptionsFiltered] = useState<Option[]>(options)

    const onPushOption = (value: string) => {
        const e : PushEvent = {
            target: {
                name,
                value
            }
        }
        onChangeFnc(e);
    }

    const onChange = (e: ChangeEvent<HTMLInputElement> | PushEvent) => {
        onChangeFnc(e)

        setOptionsFiltered(options.filter(option => option.label.toLowerCase().includes((e as ChangeEvent<HTMLInputElement>).target.value.toLowerCase())))
    }
    
    return (
        <div className="input-group">
            <label htmlFor={id}>{label}</label>
            <input 
                disabled={disable}
                onFocus={() => setShow(true)}
                onBlur={() => (setTimeout(() => setShow(false), 200))}
                type={type} 
                name={name} 
                id={id} 
                value={value} 
                placeholder={placeholder}
                onChange={onChange}
            />

            {options.length > 0 && show && (
                <div className="input-options">
                    {optionsFiltered.map(option => (
                        <button type="button" key={option.value} onClick={() => onPushOption(option.label)}>{option.label}</button>
                    ))}
                </div>
            )}
        </div>
    )
}
